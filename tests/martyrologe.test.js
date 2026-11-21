// Martyrologe et nécrologe : chaque jour de 2024 à 2044, dans les trois éditions, a ses éloges ;
// chaque frère du nécrologe est nommé une fois par an ; chaque fête mobile est lue.
//   node tests/martyrologe.test.js              (résumé)
//   node tests/martyrologe.test.js 2027-02-28 [romain|marseille|toulouse]
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
require(path.join(R, "site/js/calendrier.js"));
const Mart = require(path.join(R, "site/js/martyrologe.js"));
const C = globalThis.Calendrier;
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, "site/donnees", f)));
C.charger(lire("sanctoral.json"), lire("propre_op.json"));
const M = lire("martyrologe.json"), N = lire("necrologe.json");
const txt = (h) => h.replace(/<[^>]+>/g, "");

if (process.argv[2]) {
  const j = C.jour(C.deIso(process.argv[2]), { propreOP: true });
  const b = Mart.pour(j, M, N, process.argv[3] || "romain");
  console.log(j.dateLongue, "—", j.nom, "—", b.edition);
  if (b.mobile) console.log("[" + b.mobile.titre + "]\n  " + b.mobile.texte.map(txt).join("\n  "));
  b.eloges.forEach((p) => console.log("•", txt(p).slice(0, 140)));
  console.log(b.conclusion);
  b.defunts.concat(b.sansJour).forEach((d) => console.log("  †", d.nom, d.annee, d.lieu, d.du29 ? "(29 févr.)" : ""));
  process.exit(0);
}

let erreurs = 0;
const total = Object.values(N.jours).reduce((n, v) => n + v.length, 0) + Object.values(N.sansJour).reduce((n, v) => n + v.length, 0);
for (const ed of Object.keys(M.editions)) {
  const mobiles = new Set();
  for (let a = 2024; a <= 2044; a++) {
    let nommes = 0;
    for (let d = C.deIso(`${a}-01-01`); d <= C.deIso(`${a}-12-31`); d = C.plus(d, 1)) {
      const j = C.jour(d, { propreOP: true });
      const b = Mart.pour(j, M, N, ed);
      if (!b.eloges.length) { erreurs++; console.log(ed, C.iso(d), "aucun éloge"); }
      if (b.mobile) {
        mobiles.add(b.mobile.cle);
        if (b.mobile.texte.some((l) => /le…/.test(txt(l)))) { erreurs++; console.log(ed, C.iso(d), "date non remplie"); }
      }
      nommes += b.defunts.length + b.sansJour.length;
    }
    if (nommes !== total) { erreurs++; console.log(ed, a, `frères nommés ${nommes} / ${total}`); }
  }
  const manque = Object.keys(M.mobiles[ed]).filter((k) => k !== "marie-samedi" && !mobiles.has(k));
  console.log(`${ed.padEnd(10)} fêtes mobiles lues : ${mobiles.size} ; jamais lues : ${manque.join(", ") || "aucune"}`);
  if (manque.length) erreurs++;
}
console.log(`2024-2044, 3 éditions : ${erreurs} problème(s) ; nécrologe : ${total} frères`);
process.exit(erreurs ? 1 : 0);
