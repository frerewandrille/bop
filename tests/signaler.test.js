// Signalement d'erreurs : les pièces nécessaires sont-elles toujours en place ?
// (le 17/11/2026, une réécriture d'office.css avait effacé les styles : la bulle n'apparaissait plus)
const fs = require("fs"), path = require("path");
const site = path.join(__dirname, "..", "site");
const lire = (f) => fs.readFileSync(path.join(site, f), "utf8");
const manques = [];
const exige = (f, motif, quoi) => { if (!motif.test(lire(f))) manques.push(`${f} : ${quoi}`); };
exige("css/office.css", /\.bulle-signaler\s*\{[^}]*position:\s*absolute/, "style de la bulle « Signaler »");
exige("css/office.css", /\.signaler-pied/, "style du lien en bas de l'office");
exige("css/office.css", /\.fenetre-signaler/, "style de la fenêtre de signalement");
exige("index.html", /js\/signaler\.js/, "script signaler.js");
exige("js/app.js", /Signaler\.decorer/, "appel de Signaler.decorer");
exige("sw.js", /"signaler"/, "signaler.js dans la liste hors connexion");
exige("js/signaler.js", /selectionchange/, "bulle sur la sélection");
if (manques.length) { console.log("Signalement : manque\n  " + manques.join("\n  ")); process.exit(1); }
console.log("Signalement : toutes les pièces sont en place.");
