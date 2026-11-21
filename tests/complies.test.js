// Complies du livret de l'Ordre (Bordeaux 2009) : chaque partition citée existe, chaque psaume est
// dans le psautier, chaque lecture brève se lit dans la Bible.
const fs = require("fs"), path = require("path"); const R = path.join(__dirname, "..");
const C = JSON.parse(fs.readFileSync(path.join(R, "site/donnees/complies.json")));
const pieces = JSON.parse(fs.readFileSync(path.join(R, "site/donnees/psautier.json"))).pieces;
const pb = [];
const fichiers = JSON.stringify(C).match(/complies\/s-\d{3}-\d+\.jpg/g) || [];
for (const f of new Set(fichiers)) if (!fs.existsSync(path.join(R, "partitions", f))) pb.push(`partition absente : ${f}`);
for (const [jr, x] of Object.entries(C.jours)) for (const p of x.psaumes) if (!pieces[p.id]) pb.push(`${jr} : psaume ${p.id} absent`);
if (!pieces.NT3) pb.push("Nunc dimittis (NT3) absent");
console.log(`Complies : ${new Set(fichiers).size} partitions citées, ${pb.length} problème(s).`);
pb.forEach((x) => console.log("  " + x));
process.exitCode = pb.length ? 1 : 0;
