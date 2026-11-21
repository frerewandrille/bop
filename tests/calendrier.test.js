// Vérifie le calendrier perpétuel contre l'AELF, jour par jour, de 2018 à 2027.
//   node tests/calendrier.test.js          (résumé)
//   node tests/calendrier.test.js -v       (liste des écarts)
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
require(path.join(R, "site/js/calendrier.js"));
const C = globalThis.Calendrier;
C.charger(JSON.parse(fs.readFileSync(path.join(R, "site/donnees/sanctoral.json"))), {});
const aelf = JSON.parse(fs.readFileSync(path.join(R, "outils/aelf_informations.json")));
const bavard = process.argv.includes("-v");

const norm = (s) => (s || "").normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase()
  .replace(/[’']/g, " ").replace(/notre-dame|bienheureuse vierge marie|vierge marie/g, "marie").replace(/resurrection du seigneur/g, "paques").replace(/\b(saint|sainte|st|ste|s|bienheureuse|la|le|les|de|du|des|et|l|d)\b/g, " ")
  .replace(/[^a-z0-9]+/g, " ").trim();
const mots = (s) => new Set(norm(s).split(" ").filter((m) => m.length > 3));
function proches(a, b) {
  const A = mots(a), B = mots(b);
  if (!A.size || !B.size) return false;
  let n = 0; for (const m of A) if (B.has(m)) n++;
  return n / Math.min(A.size, B.size) >= 0.5;
}
function rangAelf(i) {
  const deg = `${i.degre || ""} ${i.fete || ""} ${i.ligne2 || ""}`;
  if (/Solennité/.test(deg)) return "solennité";
  if (/\bFête\b/.test(deg)) return "fête";
  if (/^Mémoire facultative/.test(i.ligne3 || "")) return "mémoire facultative";
  if (/^Mémoire/.test(i.ligne3 || "")) return "mémoire";
  return null;
}
function semaineAelf(i) {
  const m = /(\d+)(?:ème|ère|e|re)\s+semaine/i.exec(i.semaine || "");
  return m ? +m[1] : null;
}
// Erreurs connues de l'AELF (temps liturgique mal renseigné la veille de l'Avent)
const IGNORER = new Set();
const TEMPS = { ordinaire: "ordinaire", avent: "avent", careme: "careme", pascal: "paques", noel: "noel" };

let ok = 0, ko = 0;
const ecarts = {};
for (const [date, i] of Object.entries(aelf).sort()) {
  if (i.erreur || IGNORER.has(date)) continue;
  const j = C.jour(date);
  const ra = rangAelf(i);
  const nomA = (i.jour_liturgique_nom || "").startsWith("de la férie") || ra === "mémoire" ? i.fete : (i.ligne1 || i.jour_liturgique_nom);
  let pb = null;
  // 1. le temps et la semaine
  const ta = TEMPS[i.temps_liturgique];
  if (ta && j.temps && ta !== j.temps && !(ta === "careme" && /semaine sainte|triduum/.test(j.temps)) && !(ta === "pascal" && j.temps === "paques"))
    pb = `temps ${ta} ≠ ${j.temps}`;
  const sa = semaineAelf(i);
  if (!pb && sa && j.semaine != null && sa !== j.semaine && ta !== "careme") pb = `semaine ${sa} ≠ ${j.semaine}`;
  // 2. la célébration principale (solennité, fête, mémoire obligatoire)
  if (!pb && (ra === "solennité" || ra === "fête" || ra === "mémoire")) {
    const noms = [nomA, i.ligne1, i.ligne2, i.ligne3, i.fete, i.jour_liturgique_nom];
    if (!noms.some((n) => proches(n, j.nom))) pb = `célébration « ${nomA} » (${ra}) ≠ « ${j.nom} » (${j.rang})`;
  } else if (!pb && j.niveau <= 10 && j.source === "romain" && !/(dimanche|férie)/i.test(nomA || "") && !proches(nomA, j.nom) && !proches(i.ligne1, j.nom)) {
    pb = `l'AELF n'a pas « ${j.nom} » (${j.rang}) mais « ${i.ligne1} »`;
  }
  if (pb) { ko++; ecarts[date] = pb; } else ok++;
}
console.log(`Calendrier perpétuel / AELF : ${ok} jours concordants, ${ko} écarts`);
if (bavard) for (const [d, p] of Object.entries(ecarts)) console.log(" ", d, C.jour(d).nomJour, p);
process.exitCode = ko ? 1 : 0;
