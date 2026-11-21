// Pour chaque jour de 2026-11-29 à 2028-12-02 : le capitule trouvé aux laudes et aux vêpres.
const fs = require("fs"), path = require("path"); const R = path.join(__dirname, "..");
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, "site/donnees", f)));
for (const f of ["calendrier", "capitules"]) require(path.join(R, "site/js", f + ".js"));
const { Calendrier: K, Capitules } = globalThis;
K.charger(lire("sanctoral.json"), lire("propre_op.json")); Capitules.charger(lire("capitules.json"));
const manque = {}; let n = 0, ok = 0;
for (let d = K.deIso("2026-11-29"); d <= K.deIso("2028-12-02"); d = K.plus(d, 1)) {
  const j = K.jour(K.iso(d), { propreOP: true });
  for (const o of ["laudes", "vepres"]) { n++; const c = Capitules.pour(j, o); if (c) ok++; else (manque[j.temps + " " + o] ||= []).push(j.date + " " + j.nom.slice(0, 30)); }
}
console.log(`Capitules trouvés : ${ok}/${n}`);
for (const [k, v] of Object.entries(manque)) console.log("  sans capitule", k, v.length, v.slice(0, 6).join(" | "));
if (process.argv.includes("-j")) for (const d of process.argv.slice(3)) { const j = K.jour(d, { propreOP: true }); console.log(d, j.nom, Capitules.pour(j, "laudes"), Capitules.pour(j, "vepres")); }
