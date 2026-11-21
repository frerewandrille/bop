// Prières et formules : chaque pièce a son texte, le latin n'a plus d'accent détaché, la table des matières
// mène à chaque pièce, chaque pièce et chaque chapitre se lisent dans les trois langues, la recherche trouve.
//   node tests/prieres.test.js
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
const P = require(path.join(R, "site/js/prieres.js"));
const D = JSON.parse(fs.readFileSync(path.join(R, "site/donnees/prieres.json")));
let err = 0;
const pieces = D.groupes.flatMap((g) => g.pieces);
const ids = new Set();
for (const p of pieces) {
  if (ids.has(p.id)) { err++; console.log("id en double", p.id); } ids.add(p.id);
  if (!p.fr.length || p.fr.some((b) => !b.length || b.some((l) => !l.trim()))) { err++; console.log("texte vide", p.id); }
  const tout = [...p.fr.flat(), ...(p.la || []).flat()].join(" ");
  if (/´|&[a-z]+;|<|>/.test(tout)) { err++; console.log("reste de mise en forme", p.id); }
}
// table des matières : chaque pièce et chaque chapitre y sont ; chaque pièce et chaque chapitre se lisent dans les trois langues
const som = P.sommaire(D);
for (const p of pieces) if (!som.includes(`href="#${p.id}"`)) { err++; console.log("absente du sommaire", p.id); }
for (const gr of D.groupes) if (!som.includes(`href="#chapitre/${gr.id}"`)) { err++; console.log("chapitre absent du sommaire", gr.id); }
for (const langue of ["fr", "la", "deux"]) {
  for (const p of pieces) { const h = P.piece(D, p.id, langue); if (!h || !h.includes(`id="${p.id}"`)) { err++; console.log("pièce", p.id, langue); } }
  for (const gr of D.groupes) { const h = P.chapitre(D, gr.id, langue); if ((h.match(/<article/g) || []).length !== gr.pieces.length) { err++; console.log("chapitre", gr.id, langue); } }
}
const idx = P.index(D);
for (const [q, id] of [["salve", "salve-regina"], ["pater noster", "notre-pere"], ["acedie", "peches-capitaux"], ["caeli", "regina-caeli"], ["Theotokos", null]]) {
  const r = P.chercher(idx, q);
  if (id && !r.has(id)) { err++; console.log("recherche", q); }
}
const avecLatin = pieces.filter((p) => p.la).length;
console.log(`${pieces.length} pièces en ${D.groupes.length} groupes, ${avecLatin} avec le latin : ${err} problème(s)`);
process.exit(err ? 1 : 0);
