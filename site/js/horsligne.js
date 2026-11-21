/* Lecture hors connexion : enregistre sur l'appareil les offices d'une période.

   HorsLigne.enregistrer(debut, fin, offices, options, version, suivi) construit chaque office comme pour
   l'affichage : les textes de l'AELF se rangent d'eux-mêmes (js/aelf.js) ; on garde ensuite les fichiers de
   données utilisés (livres de la Bible, index des partitions…) et les images de partitions des offices.
   Le service worker (sw.js) les ressert quand le réseau manque. Mêmes noms de boîtes que dans sw.js. */
(function (g) {
  "use strict";
  const SITE = "breviaire-site-1", IMAGES = "breviaire-partitions-1", CLE = "breviaire-horsligne";
  const disponible = typeof caches !== "undefined" && typeof navigator !== "undefined" && "serviceWorker" in navigator && /^https?:$/.test(location.protocol);
  try { performance.setResourceTimingBufferSize(4000); } catch (e) { /* rien */ }

  const iso = (d) => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
  const decaler = (s, n) => { const d = new Date(s + "T12:00:00"); d.setDate(d.getDate() + n); return iso(d); };
  // une image de partition se range sous l'adresse du site, qu'elle vienne du site ou de l'entrepôt Azure :
  // les partitions enregistrées avant le passage à l'entrepôt restent valables
  // entrepôt privé : …blob.core.windows.net/$web/partitions/… → rangé sous l'adresse du site, sans « $web » ni clé
  const cleDe = (u) => { const url = new URL(u, location.href); const ch = url.pathname.replace(/^\/(\$|%24)web\//, "/"); return (/^\/partitions\//.test(ch) ? location.origin : url.origin) + ch.replace(/\/index\.html$/, "/"); };

  // plusieurs téléchargements de front, sans s'arrêter à un échec ; renvoie le nombre d'échecs
  async function parLots(liste, n, fn) {
    let i = 0, echecs = 0;
    await Promise.all(Array.from({ length: n }, async () => {
      while (i < liste.length) { const x = liste[i++]; try { await fn(x); } catch (e) { echecs++; } }
    }));
    return echecs;
  }
  async function garder(boite, adresse) {
    const cle = cleDe(adresse);
    if (boite === IMAGES && (await (await caches.open(boite)).match(cle))) return;
    const r = await fetch(adresse, { cache: "no-cache" });
    if (!r.ok || r.redirected) throw new Error("HTTP " + r.status);
    await (await caches.open(boite)).put(cle, r);
  }

  async function enregistrer(debut, fin, offices, options, version, suivi = () => {}) {
    if (!disponible) throw new Error("ce navigateur ne permet pas l'enregistrement hors connexion");
    const jours = [];
    for (let d = debut; d <= fin; d = decaler(d, 1)) jours.push(d);
    if (!jours.length) throw new Error("vérifiez les dates");
    if (jours.length > 100) throw new Error("période trop longue (100 jours au plus)");
    try { if (navigator.storage?.persist) await navigator.storage.persist(); } catch (e) { /* rien */ }
    const images = new Set(), manques = [];
    const total = jours.length * offices.length;
    let fait = 0;
    for (const d of jours) {
      await Promise.all(offices.map(async (o) => {
        try {
          const r = await g.Offices.construire(d, o, { ...options });
          for (const m of r.html.matchAll(/<img[^>]+src="([^"]+)"/g)) images.add(m[1].replace(/&amp;/g, "&"));
        } catch (e) { manques.push(`${d} ${g.Offices.OFFICES[o]}`); }
        suivi(++fait, total, `${fait} / ${total} offices`);
      }));
    }
    // fichiers du site déjà demandés par cette page (données, livres de la Bible, index des partitions…)
    const fichiers = new Set(["./"]);
    for (const e of performance.getEntriesByType("resource")) {
      const u = new URL(e.name);
      if (u.origin === location.origin && !/\.(jpe?g|png)$/i.test(u.pathname) && !/\/sw\.js$|\/\.auth\//.test(u.pathname)) fichiers.add(u.href);
    }
    suivi(0, fichiers.size, "Fichiers du site…");
    let k = 0;
    const echecsFichiers = await parLots([...fichiers], 6, async (u) => { try { await garder(SITE, u); } finally { suivi(++k, fichiers.size, "Fichiers du site…"); } });
    k = 0;
    const liste = [...images];
    const echecsImages = await parLots(liste, 6, async (u) => { try { await garder(IMAGES, u); } finally { suivi(++k, liste.length, `${k} / ${liste.length} partitions`); } });
    const bilan = { debut, fin, version, quand: new Date().toISOString(), offices: total - manques.length, images: liste.length - echecsImages, manques, echecsImages, echecsFichiers };
    try { localStorage.setItem(CLE, JSON.stringify({ ...bilan, manques: manques.slice(0, 20) })); } catch (e) { /* rien */ }
    return bilan;
  }

  function etat() { try { return JSON.parse(localStorage.getItem(CLE) || "null"); } catch (e) { return null; } }

  async function effacer() {
    try { localStorage.removeItem(CLE); } catch (e) { /* rien */ }
    if (typeof caches !== "undefined") await caches.delete(IMAGES);
    if (g.AELF?.vider) await g.AELF.vider();
  }

  // place occupée sur l'appareil, en Mo (null si le navigateur ne le dit pas)
  async function occupation() {
    try { const e = await navigator.storage.estimate(); return e && e.usage != null ? Math.round(e.usage / 1048576) : null; } catch (e) { return null; }
  }

  function installer() {
    if (disponible) navigator.serviceWorker.register("sw.js").catch(() => {});
  }

  g.HorsLigne = { disponible, enregistrer, etat, effacer, occupation, installer, decaler, aujourdhui: () => iso(new Date()) };
})(window);
