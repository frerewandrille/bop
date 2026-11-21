// Répartition gouzantine : pour chaque jour de deux années liturgiques, vérifie ce que trouve
// Gouzes.resoudre (psalmodie, litanie, répons…) et que toute pièce citée existe dans le psautier.
//   node tests/gouzes.test.js [-v]
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, "site/donnees", f)));
for (const f of ["calendrier", "gouzes"]) require(path.join(R, "site/js", f + ".js"));
const { Calendrier: C, Gouzes } = globalThis;
C.charger(lire("sanctoral.json"), lire("propre_op.json"));
Gouzes.charger(lire("gouzes.json"));
const P = lire("psautier.json").pieces;
const bavard = process.argv.includes("-v");

const stats = {}, manques = {}, inconnues = new Set();
const compter = (k) => (stats[k] = (stats[k] || 0) + 1);
let d = C.deIso("2026-11-29"); const fin = C.deIso("2028-12-02");
for (; d <= fin; d = C.plus(d, 1)) {
  const j = C.jour(C.iso(d), { propreOP: true });
  for (const o of ["lectures", "laudes", "vepres"]) {
    const r = Gouzes.resoudre(j, o, "gouzantine");
    const t = j.temps;
    compter(`${t}|${o}|total`);
    if (r.psalmodie) compter(`${t}|${o}|psalmodie`);
    else (manques[`${t}|${o}`] ||= []).push(j.date);
    if (r.preces) compter(`${t}|${o}|litanie`);
    if (r.repons) compter(`${t}|${o}|répons`);
    if (r.hymne) compter(`${t}|${o}|hymne`);
    for (const e of r.psalmodie || []) for (const p of e.pieces) if (!P[p.id]) inconnues.add(p.id);
  }
}
const temps = [...new Set(Object.keys(stats).map((k) => k.split("|")[0]))];
console.log("temps | office : jours avec psalmodie / litanie / répons / hymne, sur le total");
for (const t of temps) for (const o of ["lectures", "laudes", "vepres"]) {
  const s = (k) => stats[`${t}|${o}|${k}`] || 0;
  if (s("total")) console.log(`  ${t.padEnd(15)} ${o.padEnd(9)} ${s("psalmodie")}/${s("total")} psalmodie, ${s("litanie")} litanie, ${s("répons")} répons, ${s("hymne")} hymne`);
}
if (bavard) for (const [k, v] of Object.entries(manques)) console.log("  sans psalmodie", k, v.slice(0, 8).join(" "), v.length > 8 ? "…" : "");
console.log(inconnues.size ? `PIÈCES INCONNUES : ${[...inconnues].join(", ")}` : "Toutes les pièces citées existent dans le psautier.");
process.exitCode = inconnues.size ? 1 : 0;
