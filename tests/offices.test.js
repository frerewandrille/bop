// Vérifie que chaque référence employée par l'AELF dans les offices (relevée par
// outils/recolter_references.py) trouve son texte dans le psautier et dans la Bible.
//   node tests/offices.test.js [-v]
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
const bavard = process.argv.includes("-v");

// fetch local (le site lit ses données par fetch)
globalThis.fetch = async (url) => {
  const f = path.join(R, "site", String(url));
  if (!fs.existsSync(f)) return { ok: false, json: async () => null };
  const t = fs.readFileSync(f, "utf8");
  return { ok: true, json: async () => JSON.parse(t) };
};
for (const f of ["calendrier", "textes"]) require(path.join(R, "site/js", f + ".js"));
const { Psautier, Bible } = globalThis;

(async () => {
  await Psautier.charger("donnees/psautier.json");
  const refs = JSON.parse(fs.readFileSync(path.join(R, "outils/aelf_references.json")));
  const echecs = new Map(), partiels = new Map(), vus = new Set();
  let n = 0;
  for (const [cle, o] of Object.entries(refs)) {
    if (o.erreur) continue;
    for (const [champ, r] of Object.entries(o)) {
      const sig = `${champ}|${r.ref}|${r.v.join(",")}`;
      if (vus.has(sig)) continue;
      vus.add(sig);
      n++;
      if (/^psaume|^cantique/.test(champ)) {
        const sel = Psautier.trouver(r.ref, r.v);
        if (!sel) { echecs.set(`${r.ref}`, cle); continue; }
        // les versets demandés par l'AELF sont-ils tous présents ?
        if (sel.ensemble) {
          const presents = Psautier.couverture(sel);
          const manque = [...sel.ensemble].filter((v) => !presents.has(v));
          if (manque.length) partiels.set(`${r.ref} → ${sel.id}`, `versets ${manque.join(",")} (${cle})`);
          // versets imprimés en trop (hors de ce que l'AELF demande)
          const nums = [...sel.ensemble].map(Number), min = Math.min(...nums), max = Math.max(...nums);
          const trop = [...presents].map(Number).filter((v) => v < min - 1 || v > max + 1);
          const imprimes = Psautier.lignes(sel).flatMap((s) => s.lignes).filter((l) => l.v).map((l) => parseInt(l.v));
          const transp = Psautier.transpositions(sel.id); // versets déplacés par la BJ : restent à leur place
          const tropImprimes = imprimes.filter((v) => (v < min || v > max) && !transp.has(v));
          if (tropImprimes.length) partiels.set(`${r.ref} → ${sel.id} (en trop)`, `versets ${tropImprimes.join(",")} (${cle})`);
        }
      } else if (champ === "pericope" || champ === "lecture") {
        const b = await Bible.lire(r.ref);
        if (!b) echecs.set(`${r.ref}`, cle + " (référence illisible)");
        else if (b.manquants.length) partiels.set(r.ref, `manque ${b.manquants.join(" ; ")} (${cle})`);
      }
    }
  }
  console.log(`Références AELF distinctes : ${n} ; introuvables : ${echecs.size} ; incomplètes : ${partiels.size}`);
  if (bavard || echecs.size) for (const [r, c] of echecs) console.log("  INTROUVABLE", r, "—", c);
  if (bavard) for (const [r, c] of partiels) console.log("  incomplet", r, "—", c);
  process.exitCode = echecs.size ? 1 : 0;
})();
