// Office du milieu du jour (carnet de la Province) : pour chaque jour de 2026-11-29 à 2030-12-01,
// des psaumes qui existent dans le psautier, un verset et une page de partition.
const fs = require("fs"), path = require("path"); const R = path.join(__dirname, "..");
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, "site/donnees", f)));
for (const f of ["calendrier", "milieu"]) require(path.join(R, "site/js", f + ".js"));
const { Calendrier: K, Milieu } = globalThis;
K.charger(lire("sanctoral.json"), lire("propre_op.json")); Milieu.charger(lire("milieu.json"));
const pieces = lire("psautier.json").pieces;
const pb = {}; let n = 0;
const note = (k, j) => (pb[k] ||= []).push(`${j.date} ${j.nom.slice(0, 35)}`);
for (let d = K.deIso("2026-11-29"); d <= K.deIso("2030-12-01"); d = K.plus(d, 1)) {
  const j = K.jour(K.iso(d), { propreOP: true }); n++;
  const m = Milieu.pour(j);
  if (!m.ps?.length) note("sans psaume", j);
  for (const id of m.ps || []) if (!pieces[id]) note(`psaume « ${id} » absent`, j);
  if (!m.versets?.length) note("sans verset", j);
  if (!m.pages?.length) note("sans partition", j);
  if (!m.hymnes?.length) note("sans hymne", j);
  if (!m.antiennes?.length || !m.antiennes[0].ant) note("sans antienne (texte)", j);
  if (!m.antiennes?.[0]?.partition?.length) note("sans partition d'antienne", j);
  if (!m.gregoriennes?.length) note("sans hymne grégorienne", j);
}
let ko = 0;
for (const [k, v] of Object.entries(pb)) { ko += v.length; console.log(`  ${k} : ${v.length} — ${v.slice(0, 5).join(" | ")}`); }
console.log(`Milieu du jour : ${n} jours, ${ko} problème(s).`);
process.exitCode = ko ? 1 : 0;
