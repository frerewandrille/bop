// Bénédictions de table : chaque jour de 2024 à 2044 a ses formules (midi, soir, après),
// et chaque formule propre du livret est employée au moins une fois.
//   node tests/table.test.js            (résumé)
//   node tests/table.test.js 2026-12-25 (affiche un jour)
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
require(path.join(R, "site/js/calendrier.js"));
const Table = require(path.join(R, "site/js/table.js"));
const C = globalThis.Calendrier;
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, "site/donnees", f)));
C.charger(lire("sanctoral.json"), lire("propre_op.json"));
const D = lire("table.json");

const arg = process.argv[2];
if (arg) {
  for (const op of [true, false]) {
    const j = C.jour(C.deIso(arg), { propreOP: op });
    const b = Table.pour(j, D);
    console.log(`${j.dateLongue} — ${j.nom} (propre OP ${op ? "oui" : "non"})`);
    console.log("Midi :", b.midi.propre ? `[${b.midi.propre.titre}] ` + b.midi.propre.texte.join(" / ") : `formule ${b.midi.numero} : ` + b.midi.formules[b.midi.numero - 1].join(" / "));
    if (b.soir.dimanche) console.log("Soir (dimanche) :", b.soir.dimanche.join(" / "));
    console.log("Soir :", b.soir.reste.join(" / "));
  }
  process.exit(0);
}

let erreurs = 0, jours = 0;
const vus = new Map();
const plein = (l) => Array.isArray(l) && l.length && l.every((s) => typeof s === "string" && s.trim());
for (const op of [true, false])
  for (let d = C.deIso("2024-01-01"); d <= C.deIso("2044-12-31"); d = C.plus(d, 1)) {
    const j = C.jour(d, { propreOP: op });
    const b = Table.pour(j, D);
    jours++;
    const pb = [];
    if (b.midi.propre && !plein(b.midi.propre.texte)) pb.push("propre vide");
    if (b.midi.propre && b.midi.propre.texte.some((l) => /\(x\)|undefined/.test(l))) pb.push("complément manquant");
    if (!b.midi.formules || b.midi.formules.length !== 4 || !b.midi.formules.every(plein)) pb.push("formules du jour");
    if (!plein(b.soir.reste)) pb.push("soir");
    if (j.jourSemaine === 0 && !plein(b.soir.dimanche)) pb.push("soir du dimanche");
    if (!plein(b.apres)) pb.push("après le repas");
    if (pb.length) { erreurs++; if (erreurs < 20) console.log(C.iso(d), j.nom, pb.join(", ")); }
    if (b.midi.propre) {
      const k = b.midi.propre.cle;
      if (!vus.has(k)) vus.set(k, { n: 0, ex: C.iso(d) + " " + j.nom });
      vus.get(k).n++;
    }
  }

const attendues = [...Object.keys(D.propres).filter((k) => k !== "evangelistes" || true), ...Object.keys(D.marie.x).map((k) => "marie-" + k)];
const jamais = attendues.filter((k) => !vus.has(k));
for (const [k, v] of [...vus].sort()) console.log(`  ${k.padEnd(28)} ${String(v.n).padStart(4)}  ex. ${v.ex}`);
console.log(`${jours} jours (avec et sans propre OP) : ${erreurs} jour(s) incomplet(s) ; formules propres jamais employées : ${jamais.join(", ") || "aucune"}`);
process.exit(erreurs || jamais.length ? 1 : 0);
