// Version « 100 % AELF » : chaque psaume / cantique employé par l'AELF (outils/aelf_references.json)
// doit se trouver dans le psautier AELF à inflexions (site/donnees/psautier_aelf.json), versets compris.
//   node tests/psautier_aelf.test.js [-v]
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
const bavard = process.argv.includes("-v");
globalThis.fetch = async (url) => {
  const f = path.join(R, "site", String(url));
  if (!fs.existsSync(f)) return { ok: false, json: async () => null };
  const t = fs.readFileSync(f, "utf8");
  return { ok: true, json: async () => JSON.parse(t) };
};
require(path.join(R, "site/js/textes.js"));
const PA = globalThis.PsautierAELF;

(async () => {
  await PA.charger("donnees/psautier_aelf.json");
  // gras seulement, jamais de souligné ; chaque pièce a du texte
  for (const [id, p] of Object.entries(PA.donnees.pieces)) {
    if (!p.strophes.length) console.log("  VIDE", id);
    for (const s of p.strophes) for (const l of s.lignes) if (/<u>|\[|\]/.test(l.t)) console.log("  ANOMALIE", id, l.t);
  }
  const refs = JSON.parse(fs.readFileSync(path.join(R, "outils/aelf_references.json")));
  const echecs = new Map(), partiels = new Map(), vus = new Set();
  let n = 0;
  for (const [cle, o] of Object.entries(refs)) {
    if (o.erreur) continue;
    for (const [champ, r] of Object.entries(o)) {
      if (!/^psaume|^cantique/.test(champ)) continue;
      const v = r.v.filter((x) => /^\d/.test(x));
      const sig = `${r.ref}|${v.join(",")}`;
      if (vus.has(sig)) continue;
      vus.add(sig); n++;
      const sel = PA.trouver(r.ref, v);
      if (!sel) { echecs.set(r.ref, cle); continue; }
      if (sel.ensemble) {
        const presents = PA.couverture(sel);
        const manque = [...sel.ensemble].filter((x) => !presents.has(x));
        if (manque.length) partiels.set(`${r.ref} → ${sel.id} manque`, `${manque.join(",")} (${cle})`);
        const nums = [...sel.ensemble].map(Number), min = Math.min(...nums), max = Math.max(...nums);
        const trop = PA.lignes(sel).flatMap((s) => s.lignes).filter((l) => l.v).map((l) => parseInt(l.v)).filter((x) => x < min || x > max);
        if (trop.length) partiels.set(`${r.ref} → ${sel.id} en trop`, `${trop.join(",")} (${cle})`);
      }
    }
  }
  console.log(`Psaumes/cantiques AELF distincts : ${n} ; introuvables : ${echecs.size} ; incomplets : ${partiels.size}`);
  for (const [r, c] of echecs) console.log("  INTROUVABLE", r, "—", c);
  if (bavard || partiels.size < 40) for (const [r, c] of partiels) console.log("  ", r, "—", c);
  process.exitCode = echecs.size ? 1 : 0;
})();
