// Lectionnaire de J.-R. Bouchet : chaque entrée trouve au moins un jour (2026-2045), chaque lecture a un texte.
//   node tests/bouchet.test.js            (résumé)
//   node tests/bouchet.test.js 2027-03-25 (lectures proposées ce jour-là)
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
require(path.join(R, "site/js/calendrier.js"));
require(path.join(R, "site/js/bouchet.js"));
const C = globalThis.Calendrier, B = globalThis.Bouchet;
C.charger(JSON.parse(fs.readFileSync(path.join(R, "site/donnees/sanctoral.json"))), JSON.parse(fs.readFileSync(path.join(R, "site/donnees/propre_op.json"))));
const D = JSON.parse(fs.readFileSync(path.join(R, "site/donnees/bouchet.json")));
B.charger(D);

const arg = process.argv[2];
if (arg) {
  const j = C.jour(arg, { propreOP: true });
  console.log(j.nom);
  for (const x of B.pour(j, { propreOP: true })) for (const l of x.lectures) console.log(`  ${x.titre}${x.note ? ` (${x.note})` : ""} — ${l.lecon ? l.lecon + " : " : ""}${l.auteur}`);
  process.exit(0);
}

let erreurs = 0;
const vues = new Set(), sansRien = [];
for (const op of [true, false]) {
  for (let d = C.deIso("2026-01-01"); d <= C.deIso("2045-12-31"); d = C.plus(d, 1)) {
    const j = C.jour(C.iso(d), { propreOP: op });
    const ks = B.cles(j, { propreOP: op });
    ks.forEach((k) => vues.add(k));
    if (!ks.length && op && d.getUTCFullYear() === 2027) sansRien.push(`${j.date} ${j.nom}`);
  }
}
const nonVues = Object.keys(D.entrees).filter((k) => !vues.has(k));
if (nonVues.length) { erreurs++; console.log("Entrées jamais proposées :", nonVues.join(", ")); }
for (const [k, e] of Object.entries(D.entrees))
  for (const x of [e, ...(e.variantes || [])])
    for (const l of x.lectures) if (!l.texte.length) { erreurs++; console.log(`Lecture sans texte : ${k} ${l.auteur}`); }
// quelques jours connus
const attendu = { "2026-11-29": "avent-1-0", "2026-12-18": "feries-17-24", "2027-02-17": "careme-1-3", "2027-03-25": "careme-6-4",
  "2027-05-23": "trinite", "2027-05-18": "autres-pentecote", "2027-08-08": "08-08", "2027-01-28": "01-28", "2027-05-05": "05-05",
  "2028-01-16": "cana", "2027-03-25": "careme-6-4", "2027-04-05": "03-25", "2027-07-14": "autres-to", "2026-12-30": "autres-noel", "2027-01-07": "01-07", "2027-01-08": "autres-epiphanie" };
for (const [d, k] of Object.entries(attendu)) {
  const ks = B.cles(C.jour(d, { propreOP: true }), { propreOP: true });
  if (!ks.includes(k)) { erreurs++; console.log(`${d} : attendu ${k}, obtenu ${ks.join(", ") || "rien"}`); }
}
// impression : jour propre → toutes ses lectures ; « autres lectures » → une seule, à tour de rôle
{
  require(path.join(R, "site/js/textes.js"));
  const esc = globalThis.Textes.esc, n = (h) => (h.match(/lecture-bouchet-retenue/g) || []).length;
  const noel = B.rendu(C.jour("2026-12-25", { propreOP: true }), { propreOP: true }, esc);
  if (n(noel.imprime) !== 3) { erreurs++; console.log("Noël : les trois leçons devraient être imprimées"); }
  const a = B.rendu(C.jour("2027-07-14", { propreOP: true }), { propreOP: true }, esc), b = B.rendu(C.jour("2027-07-15", { propreOP: true }), { propreOP: true }, esc);
  if (n(a.imprime) !== 1 || a.imprime === b.imprime) { erreurs++; console.log("Temps ordinaire : une lecture par jour, différente d'un jour à l'autre"); }
}
console.log(`${Object.keys(D.entrees).length} entrées ; jours de 2027 sans lecture proposée : ${sansRien.length} (féries de Carême sans propre)`);
console.log(erreurs ? `${erreurs} erreur(s)` : "OK");
process.exit(erreurs ? 1 : 0);
