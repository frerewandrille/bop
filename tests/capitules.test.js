// Chaque capitule de la Province doit se lire dans la Bible de Jérusalem.
//   node tests/capitules.test.js
const fs = require("fs"), path = require("path");
const R = path.join(__dirname, "..");
globalThis.fetch = async (u) => { const f = path.join(R, "site", String(u)); return fs.existsSync(f) ? { ok: true, json: async () => JSON.parse(fs.readFileSync(f, "utf8")) } : { ok: false, json: async () => null }; };
require(path.join(R, "site/js/textes.js"));
const C = JSON.parse(fs.readFileSync(path.join(R, "site/donnees/capitules.json")));
const refs = [];
(function parcourir(x, chemin) {
  if (typeof x === "string") refs.push([chemin, x]);
  else if (Array.isArray(x)) x.forEach((v, i) => parcourir(v, chemin + "/" + i));
  else if (x && typeof x === "object") for (const [k, v] of Object.entries(x)) if (k !== "nom" && k !== "incertain") parcourir(v, chemin + "/" + k);
})(C, "");
(async () => {
  let ko = 0;
  for (const [c, r] of refs) {
    const b = await globalThis.Bible.lire(r);
    if (!b || !b.html || b.manquants.length) { ko++; console.log("  PROBLÈME", c, r, b ? b.manquants.join(" ") : "illisible"); }
  }
  console.log(`Capitules : ${refs.length} références, ${ko} problème(s).`);
  process.exitCode = ko ? 1 : 0;
})();
