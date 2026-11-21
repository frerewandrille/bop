/* Accès à l'API de l'AELF (https://api.aelf.org), interrogée directement par le navigateur.

   L'AELF ne publie ses offices que pour une fenêtre d'années (2018-2027 au moment
   de l'écriture). Pour une date hors de cette fenêtre, on prend le même jour
   liturgique dans une année couverte (calculé par Calendrier) :
     - férie, dimanche, temps fort : même jour du temporal (et même cycle A/B/C le dimanche) ;
     - solennité, fête, mémoire à date fixe : même célébration une autre année ;
       pour une mémoire, la psalmodie vient de la férie équivalente.
*/
(function (g) {
  "use strict";
  const C = () => g.Calendrier;
  const API = "https://api.aelf.org/v1";
  let ZONE = "france";
  const FENETRE = { debut: 2018, fin: 2027 };
  const memoire = new Map();
  const enCours = new Map();

  // Mémoire durable des réponses de l'AELF (« Cache Storage » du navigateur : plusieurs centaines de Mo
  // possibles, là où l'ancien localStorage plafonnait à 5 Mo). Sert aussi à la lecture hors connexion.
  // Une date que l'AELF ne publie pas (404) est notée { __absent: instant } pour ne pas la redemander sans réseau.
  const BOITE = "breviaire-aelf-1";
  let boite = null;
  const ouvrir = () => (boite || (boite = typeof caches !== "undefined" ? caches.open(BOITE).catch(() => null) : Promise.resolve(null)));
  try { for (const k of Object.keys(localStorage)) if (k.startsWith("aelf1:")) localStorage.removeItem(k); } catch (e) { /* ancien cache : rien à faire */ }
  async function lireCache(cle) {
    if (memoire.has(cle)) return memoire.get(cle);
    try {
      const c = await ouvrir(), r = c && (await c.match(`${API}/${cle}`));
      if (r) { const v = await r.json(); memoire.set(cle, v); return v; }
    } catch (e) { /* stockage indisponible */ }
    return null;
  }
  function ecrireCache(cle, v) {
    memoire.set(cle, v);
    ouvrir().then((c) => c && c.put(`${API}/${cle}`, new Response(JSON.stringify(v), { headers: { "content-type": "application/json" } }))).catch(() => {});
  }
  async function vider() {
    memoire.clear(); boite = null;
    try { if (typeof caches !== "undefined") await caches.delete(BOITE); } catch (e) { /* rien */ }
  }

  // file d'attente : au plus 4 requêtes simultanées
  let actifs = 0; const file = [];
  function limite(fn) {
    return new Promise((ok, ko) => {
      const lancer = () => { actifs++; fn().then(ok, ko).finally(() => { actifs--; if (file.length) file.shift()(); }); };
      actifs < 4 ? lancer() : file.push(lancer);
    });
  }

  async function brut(office, date) {
    const cle = `${office}/${date}/${ZONE}`;
    const c = await lireCache(cle);
    const absent = c && c.__absent;
    if (c && !absent) return c;
    const horsLigne = typeof navigator !== "undefined" && navigator.onLine === false;
    if (absent && (horsLigne || Date.now() - absent < 864e5)) return null;   // redemandé au plus une fois par jour
    if (enCours.has(cle)) return enCours.get(cle);
    const p = limite(async () => {
      for (let essai = 0; essai < 3; essai++) {
        try {
          const r = await fetch(`${API}/${office}/${date}/${ZONE}`);
          if (r.status === 404 || r.status === 400) { ecrireCache(cle, { __absent: Date.now() }); return null; }
          const ct = r.headers.get("content-type") || "";
          if (!r.ok || !ct.includes("json")) { if (r.ok) return null; throw new Error("HTTP " + r.status); }
          const j = await r.json();
          ecrireCache(cle, j);
          return j;
        } catch (e) {
          if (essai === 2 || horsLigne) { if (absent) return null; throw e; }
          await new Promise((t) => setTimeout(t, 800 * (essai + 1)));
        }
      }
    });
    enCours.set(cle, p);
    try { return await p; } finally { enCours.delete(cle); }
  }

  // ── Équivalences pour les dates hors fenêtre
  let index = null;
  function construireIndex() {
    index = { temporal: new Map(), sanctoral: new Map() };
    const d0 = C().deIso(`${FENETRE.debut}-01-01`), d1 = C().deIso(`${FENETRE.fin}-12-31`);
    for (let d = d0; d <= d1; d = C().plus(d, 1)) {
      const j = C().jour(d); // calendrier romain seul : c'est celui de l'AELF
      const kt = j.cleTemporal + (j.jourSemaine === 0 ? "|" + j.cycle : "");
      if (!index.temporal.has(kt)) index.temporal.set(kt, []);
      // on ne garde comme modèle temporel que les jours où l'AELF célèbre la férie elle-même
      index.temporal.get(kt).push({ date: j.date, libre: j.source === "temporal", js: j.jourSemaine, pair: j.pair });
      if (j.cleSanctoral) {
        if (!index.sanctoral.has(j.cleSanctoral)) index.sanctoral.set(j.cleSanctoral, []);
        index.sanctoral.get(j.cleSanctoral).push({ date: j.date, js: j.jourSemaine });
      }
    }
  }
  const dansFenetre = (iso) => { const a = +iso.slice(0, 4); return a >= FENETRE.debut && a <= FENETRE.fin; };

  function equivalents(iso, force = false) {
    if (!force && dansFenetre(iso)) return { principal: iso, psalmodie: iso, exact: true };
    if (!index) construireIndex();
    const j = C().jour(iso);
    const kt = j.cleTemporal + (j.jourSemaine === 0 ? "|" + j.cycle : "");
    const candT = (index.temporal.get(kt) || index.temporal.get(j.cleTemporal) || []);
    const temporal = (candT.find((x) => x.libre && x.pair === j.pair) || candT.find((x) => x.libre) || candT[0] || {}).date;
    let principal = temporal;
    if (j.cleSanctoral && j.source === "romain") {
      const cs = index.sanctoral.get(j.cleSanctoral) || [];
      const s = cs.find((x) => x.js === j.jourSemaine) || cs[0];
      if (s) principal = s.date;
    }
    return { principal: principal || temporal, psalmodie: j.niveau >= 9.9 && temporal ? temporal : principal || temporal, exact: false };
  }

  // Choix de l'office (saint ou férie) différent de celui que l'AELF célèbre ce jour-là
  function equivalentsChoix(iso, j) {
    if (!j?.choixManuel) return null;
    if (!index) construireIndex();
    const base = C().jour(iso);                         // ce que l'AELF célèbre (calendrier romain)
    if (j.choix === "temporal") {
      if (!base.cleSanctoral) return null;
      const cand = (index.temporal.get(j.cleTemporal) || []).filter((x) => x.libre);
      const t = (cand.find((x) => x.pair === j.pair) || cand[0])?.date;
      return t ? { principal: t, psalmodie: t, exact: false, choix: true } : null;
    }
    if (j.choix === base.cleSanctoral) return null;
    const cs = index.sanctoral.get(j.choix) || [];
    const s = (cs.find((x) => x.js === j.jourSemaine) || cs[0])?.date;
    return s ? { principal: s, psalmodie: iso, exact: false, choix: true } : null;
  }

  // Office du jour, avec la date AELF réellement utilisée
  async function office(nom, iso, j) {
    let eq = equivalentsChoix(iso, j) || equivalents(iso);
    let principal = eq.principal ? await brut(nom, eq.principal) : null;
    // l'AELF ne publie que quelques mois à l'avance : date pas encore publiée → même jour liturgique d'une autre année
    if (!principal && eq.exact) {
      eq = equivalents(iso, true);
      principal = eq.principal && eq.principal !== iso ? await brut(nom, eq.principal) : null;
    }
    let psalmodie = null;
    if (eq.psalmodie && eq.psalmodie !== eq.principal) psalmodie = await brut(nom, eq.psalmodie);
    return {
      donnees: principal ? principal[nom] : null,
      informations: principal ? principal.informations : null,
      psalmodie: psalmodie ? psalmodie[nom] : null,
      source: eq.principal, sourcePsalmodie: eq.psalmodie, exact: eq.exact, choix: !!eq.choix,
    };
  }

  g.AELF = { office, brut, equivalents, vider, zone: (z) => (ZONE = z), FENETRE };
})(typeof window !== "undefined" ? window : globalThis);
