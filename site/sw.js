/* Service worker : fait ouvrir le bréviaire sans réseau.

   - Fichiers du site (pages, scripts, données) : le réseau d'abord, pour toujours avoir la dernière
     version ; la copie gardée sert quand le réseau manque ou tarde (4 s).
   - Images de partitions : la copie gardée d'abord. Elles ne sont gardées que par « Enregistrer »
     (réglages, bloc « Hors connexion » : voir js/horsligne.js), jamais à la simple consultation.
   - Les textes de l'AELF sont gardés par js/aelf.js, pas ici.
   Les noms des deux boîtes sont les mêmes que dans js/horsligne.js. */
const SITE = "breviaire-site-1";
const IMAGES = "breviaire-partitions-1";
const COQUE = [
  "table.html", "css/table.css", "js/table.js", "donnees/table.json",   // bénédiction de la table
  "martyrologe.html", "js/martyrologe.js", "donnees/martyrologe.json", "donnees/necrologe.json",
  "prieres.html", "js/prieres.js", "donnees/prieres.json",
  "bibliotheque.html", "defunts.html", "messe.html", "css/messe.css", "js/messe.js", "donnees/missel.json", "js/menu.js", "css/menu.css", "js/bibliotheque.js", "js/defunts.js",
  "./", "manifest.webmanifest", "icone.svg", "apple-touch-icon.png", "icone-192.png", "icone-512.png", "css/polices.css", "css/office.css", "css/impression.css",
  ...["Regular", "Italic", "Medium", "MediumIt", "SemiboldIt", "Bold", "BoldIt", "MediumCapt", "ItCapt", "SemiboldCapt", "BoldCapt",
    "Subh", "ItSubh", "MediumSubh", "SemiboldSubh", "Disp", "ItDisp", "MediumDisp", "SemiboldDisp"].map((f) => `polices/kepler-${f}.woff2`),
  ...["cle-fichiers", "calendrier", "textes", "aelf", "partitions", "gouzes", "saintebaume", "milieu", "capitules", "bouchet", "latin", "communs", "propreop", "offices", "docx", "horsligne", "signaler", "app"].map((f) => `js/${f}.js`),
  ...["psautier", "psautier_aelf", "psautier_latin", "sanctoral", "propre_op", "gouzes", "milieu", "jours_saints", "complies", "capitules", "province", "president", "bouchet", "sainte_baume", "missel_op", "offices_op"].map((f) => `donnees/${f}.json`),
  "donnees/bible/index.json",
];

self.addEventListener("install", (e) => {
  e.waitUntil((async () => {
    const c = await caches.open(SITE);
    // un fichier manquant ne doit pas empêcher l'installation
    await Promise.all(COQUE.map((u) => fetch(u, { cache: "reload" }).then((r) => (r.ok && !r.redirected ? c.put(new URL(u, self.registration.scope).href, r) : null)).catch(() => null)));
    await self.skipWaiting();
  })());
});

self.addEventListener("activate", (e) => {
  e.waitUntil((async () => {
    for (const k of await caches.keys()) if (/^breviaire-(site|partitions)-/.test(k) && k !== SITE && k !== IMAGES) await caches.delete(k);
    await self.clients.claim();
  })());
});

// clé de rangement : l'adresse sans « ?v=… » ; index.html = la racine
const cleDe = (url) => url.origin + url.pathname.replace(/\/index\.html$/, "/");

async function reseauDAbord(req, cle) {
  const cache = await caches.open(SITE);
  const garde = await cache.match(cle);
  const reseau = fetch(req).then((r) => {
    if (r.type === "opaqueredirect") return r;                    // page de connexion (mot de passe du site) : au navigateur de suivre
    if (r.ok && r.type === "basic" && !r.redirected) { cache.put(cle, r.clone()).catch(() => {}); return r; }
    return garde || r;                                            // session expirée, erreur du serveur : la copie gardée
  });
  if (!garde) return reseau;
  return Promise.race([reseau.catch(() => garde), new Promise((ok) => setTimeout(() => ok(garde), 4000))]);
}

self.addEventListener("fetch", (e) => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);
  // images de partitions venues de l'entrepôt Azure (*.blob.core.windows.net/$web/…, avec clé d'accès ; avant le
  // 18/11/2026 *.web.core.windows.net) : même rangement que celles du site, sans « $web » ni clé
  if (/\/partitions\/.*\.(jpe?g|png)$/i.test(url.pathname) && url.origin !== self.location.origin && /\.(web|blob)\.core\.windows\.net$/.test(url.hostname)) {
    const cle = self.location.origin + url.pathname.replace(/^\/(\$|%24)web\//, "/");
    e.respondWith(caches.open(IMAGES).then((c) => c.match(cle)).then((r) => r || fetch(req)));
    return;
  }
  // /.auth/ et /api/ (connexion par compte, signalements) : jamais gardés, toujours au réseau
  if (url.origin !== self.location.origin || url.pathname.includes("/.auth/") || url.pathname.startsWith("/api/") || url.pathname.endsWith("/sw.js")) return;
  if (url.pathname.startsWith("/bible/")) return;                // la Bible (dossier bible/) se sert sans ce service worker
  const cle = cleDe(url);
  if (/\/partitions\/.*\.(jpe?g|png)$/i.test(url.pathname)) {
    e.respondWith(caches.open(IMAGES).then((c) => c.match(cle)).then((r) => r || fetch(req)));
    return;
  }
  // polices (ne changent jamais) et fichiers versionnés (« ?v=N » change à chaque modification) : la copie gardée
  // d'abord, sans attendre le réseau. Avant, chaque changement de page redemandait les 19 polices au réseau :
  // le texte s'affichait un instant dans une police de secours puis « sautait » (effet de flou, 18/11/2026).
  if (/\.woff2$/.test(url.pathname) || url.searchParams.has("v")) {
    e.respondWith(gardeDAbord(req, cle, url));
    return;
  }
  e.respondWith(reseauDAbord(req, cle));
});

async function gardeDAbord(req, cle, url) {
  const cache = await caches.open(SITE);
  const exacte = url.searchParams.has("v") ? url.href : cle;       // version dans la clé : une nouvelle version se recharge
  const garde = await cache.match(exacte);
  if (garde) return garde;
  try {
    const r = await fetch(req);
    if (r.ok && r.type === "basic" && !r.redirected) { cache.put(exacte, r.clone()).catch(() => {}); cache.put(cle, r.clone()).catch(() => {}); }
    return r;
  } catch (err) {
    return (await cache.match(cle)) || Response.error();             // hors connexion : la copie sans version
  }
}
