// Propre de l'Ordre (donnees/missel_op.json) : chaque messe de l'année se construit, avec chaque choix possible ;
// les célébrations de l'Ordre qui ont un degré ont leur prière (offices) quand le Missel de l'Ordre en donne une.
// node tests/missel_op.test.js
const fs = require("fs"), path = require("path");
const R = path.join(__dirname, "..", "site");
const J = (f) => JSON.parse(fs.readFileSync(path.join(R, "donnees", f + ".json"), "utf8"));
require(path.join(R, "js/calendrier.js"));
const Messe = require(path.join(R, "js/messe.js"));
const PropreOP = require(path.join(R, "js/propreop.js"));
Calendrier.charger(J("sanctoral"), J("propre_op"));
const missel = J("missel"); missel.op = J("missel_op"); PropreOP.charger(missel.op);
let pb = 0, n = 0, op = 0, prieres = 0;
let d = Calendrier.deIso("2026-11-29");
for (let i = 0; i < 366 * 2; i++, d = Calendrier.plus(d, 1)) {
  const j = Calendrier.jour(d, { propreOP: true });
  const O = Messe.options(j, missel);
  for (const o of O.liste) {
    try {
      const r = Messe.construire(j, null, missel, 0, { messe: o.cle, renvois: true }); n++;
      if (o.saint && o.saint.source === "op" && !/id="m-priere"/.test(r.html) && o.saint.messes.length) { pb++; console.log("sans prière :", j.date, o.nom); }
    } catch (e) { pb++; console.log("ERREUR", j.date, o.cle, e.message); }
  }
  if (O.liste.some((o) => o.cle.startsWith("op"))) op++;
  if (j.source === "op" && PropreOP.priere(j)) prieres++;
}
// livre « Missel OP » : chaque pièce se rend
let pieces = 0;
for (const c of Messe.livreOP.index(missel)) for (const gr of c.groupes) for (const p of gr.pieces) {
  try { p.rendu(); pieces++; } catch (e) { pb++; console.log("ERREUR Missel OP", c.id, p.id, e.message); }
}
const cal = PropreOP.vueCalendrier("2027-01-07");
if (!/S\. Raymond/.test(cal.html)) { pb++; console.log("calendrier de l'Ordre incomplet"); }
console.log(`Missel de l'Ordre : ${n} messes construites sur deux ans, ${op} jours avec une messe de l'Ordre proposée, ${prieres} jours d'office avec la prière du Missel de l'Ordre, ${pieces} pièces du Missel OP : ${pb} problème(s).`);
process.exit(pb ? 1 : 0);
