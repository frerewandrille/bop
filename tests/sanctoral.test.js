// Sanctoral des carnets de la Province : chaque fête, solennité ou mémoire du calendrier qui figure dans les
// carnets reçoit, à laudes et à vêpres, une hymne (ou un lucernaire), des antiennes et un répons ; tous les
// fichiers cités existent. Liste aussi les fêtes du calendrier absentes des carnets.
const fs = require("fs"), path = require("path"); const R = path.join(__dirname, "..");
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, f)));
globalThis.Textes = { esc: (x) => x };
for (const f of ["calendrier", "partitions"]) require(path.join(R, "site/js", f + ".js"));
const { Calendrier: K, Partitions: P } = globalThis;
K.charger(lire("site/donnees/sanctoral.json"), lire("site/donnees/propre_op.json"));
if (!fs.existsSync(path.join(R, "partitions/ordo.json"))) { console.log("Sanctoral : partitions/ordo.json absent (test sauté)."); process.exit(0); }
const ORDO = lire("partitions/ordo.json"); P.definirOrdo(ORDO);
const pb = {}, vus = new Set(), absents = new Map(); let n = 0;
const note = (k, t) => (pb[k] ||= new Set()).add(t);
const opts = { propreOP: true };
for (let d = K.deIso("2026-11-29"); d <= K.deIso("2030-12-01"); d = K.plus(d, 1)) {
  const j = K.jour(K.iso(d), opts);
  const cle = P.cleOrdo(j);
  if (!cle) {
    if (j.niveau <= 8 && j.source !== "temporal") absents.set(j.date.slice(5) + " " + j.nom, j.rang);
    continue;
  }
  vus.add(cle);
  for (const office of ["laudes", "vepres", "lectures"]) {
    const o = P.ordoPour(j, office, opts);
    if (!o) { if (office !== "lectures" && !(office === "vepres" && j.jourSemaine === 6) && ORDO[cle].offices[office]) {
      const dem = K.jour(K.iso(K.plus(d, 1)), opts); if (!(dem.niveau <= 4 && dem.niveau < j.niveau)) note("office du carnet non proposé", `${cle} ${office} (${j.date})`); }
      continue; }
    n++;
    const roles = new Set(o.pieces.map((x) => x.role));
    if (!roles.has("hymne") && !roles.has("lucernaire")) note("sans hymne ni lucernaire", `${cle} ${office}`);
    if (!roles.has("repons")) note("sans répons", `${cle} ${office}`);
    if (!roles.has("antiennes") && !o.feriale) note("sans antienne", `${cle} ${office}`);
    for (const x of o.pieces) for (const f of x.fichiers) if (!fs.existsSync(path.join(R, "partitions", f))) note("fichier absent", f);
  }
}
const jamais = Object.keys(ORDO).filter((k) => !k.startsWith("_") && !vus.has(k)).map((k) => `${k} ${ORDO[k].nom}`);
let ko = 0;
for (const [k, v] of Object.entries(pb)) { ko += v.size; console.log(`  ${k} : ${v.size} — ${[...v].slice(0, 12).join(" | ")}`); }
console.log(`  Fêtes et solennités du calendrier sans page dans les carnets du sanctoral (${absents.size}) :`);
for (const [k, r] of [...absents].sort()) console.log(`    ${k} (${r})`);
console.log(`  Pages des carnets qui ne servent que si on choisit l'office (mémoire facultative, anniversaire) : ${jamais.join(" | ") || "aucune"}`);
console.log(`Sanctoral : ${vus.size} fêtes des carnets rencontrées, ${n} offices construits, ${ko} problème(s).`);
process.exitCode = ko ? 1 : 0;
