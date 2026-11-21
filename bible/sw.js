/* Service worker de la Bible (dossier bible/) : lecture hors connexion.

   - Données (data/…, et le Psautier du bréviaire ../donnees/psautier.json) : la copie enregistrée d'abord, puis,
     si le réseau répond, la copie est rafraîchie en arrière-plan. Elles ne sont enregistrées que par la page
     « Hors connexion » (lectio.js), paquet par paquet, jamais à la simple consultation.
     En ligne, les données viennent de l'entrepôt Azure (balise <meta name="fichiers">) : elles sont rangées
     sous l'adresse de la Bible, quelle que soit leur origine.
   - Pages, scripts, styles, polices : le réseau d'abord (dernière version), la copie gardée si le réseau manque
     ou tarde (4 s).
   Le bréviaire (dossier parent) a son propre service worker, qui laisse la Bible à celui-ci.
   Mêmes noms de boîtes que dans lectio.js (HL_PAGES, HL_DONNEES). */
const PAGES = "bible-pages-1";
const DONNEES = "bible-donnees-1";
const RACINE = new URL("./", self.location).href;          // …/bible/

self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (e) => {
  e.waitUntil((async () => {
    for (const k of await caches.keys()) if (/^bible-(pages|donnees)-/.test(k) && k !== PAGES && k !== DONNEES) await caches.delete(k);
    await self.clients.claim();
  })());
});

// clé de rangement d'une donnée : …/bible/data/… (qu'elle vienne du site ou de l'entrepôt), sans « ?v= »
function cleDonnee(url) {
  const i = url.pathname.indexOf("/data/");
  if (i >= 0 && (url.origin === self.location.origin ? url.href.startsWith(RACINE) : /\.(web|blob)\.core\.windows\.net$/.test(url.hostname)))
    return RACINE + url.pathname.slice(i + 1);
  if (url.origin === self.location.origin && /\/donnees\/psautier\.json$/.test(url.pathname)) return url.origin + url.pathname;
  return null;
}

async function donnee(req, cle) {
  const cache = await caches.open(DONNEES);
  if (req.cache === "no-cache" || req.cache === "reload") return fetch(req);   // mise à jour demandée par la page
  const garde = await cache.match(cle);
  if (garde) {
    // rafraîchit la copie enregistrée en arrière-plan (nouvelle publication, corrections)
    fetch(req.url, { mode: "cors", cache: "no-cache" }).then((r) => { if (r.ok && !r.redirected) cache.put(cle, r); }).catch(() => {});
    return garde;
  }
  return fetch(req);
}

async function page(req, cle) {
  const cache = await caches.open(PAGES);
  const garde = await cache.match(cle);
  const reseau = fetch(req).then((r) => {
    if (r.type === "opaqueredirect") return r;
    if (r.ok && !r.redirected && (r.type === "basic" || r.type === "cors")) { cache.put(cle, r.clone()).catch(() => {}); return r; }
    return garde || r;
  });
  if (!garde) return reseau;
  return Promise.race([reseau.catch(() => garde), new Promise((ok) => setTimeout(() => ok(garde), 4000))]);
}

self.addEventListener("fetch", (e) => {
  const req = e.request;
  if (req.method !== "GET") return;
  const url = new URL(req.url);
  const cle = cleDonnee(url);
  if (cle) { e.respondWith(donnee(req, cle)); return; }
  if (url.origin === self.location.origin && url.href.startsWith(RACINE) && !url.pathname.endsWith("/sw.js") && !url.pathname.includes("/.auth/")) {
    const k = url.origin + url.pathname.replace(/\/index\.html$/, "/");
    e.respondWith(page(req, k));
    return;
  }
  // polices de Google (Gentium, hébreu) : gardées à la première lecture
  if (/^fonts\.(googleapis|gstatic)\.com$/.test(url.hostname)) {
    e.respondWith(caches.open(PAGES).then(async (c) => {
      const g = await c.match(req.url);
      if (g) return g;
      const r = await fetch(req);
      if (r.ok || r.type === "opaque") c.put(req.url, r.clone()).catch(() => {});
      return r;
    }));
  }
});
