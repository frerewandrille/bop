// Version « Sainte-Baume » : chaque jour de Carême (2027-2031) et chaque jour de l'année (milieu du jour)
// trouve dans les livrets ses antiennes, psaumes, répons et partitions, sans pièce manquante.
//   node tests/saintebaume.test.js
const fs = require("fs");
const path = require("path");
global.window = global;
const R = path.join(__dirname, "..");
for (const f of ["calendrier", "gouzes", "saintebaume"]) require(path.join(R, "site/js", f + ".js"));
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, f), "utf8"));
Calendrier.charger(lire("site/donnees/sanctoral.json"), lire("site/donnees/propre_op.json"));
Gouzes.charger(lire("site/donnees/gouzes.json"));
const SB = lire("site/donnees/sainte_baume.json");
SainteBaume.charger(SB);
Gouzes.ajouterCotes(SB.cotes);
const P = lire("site/donnees/psautier.json").pieces;
const image = (f) => !f || fs.existsSync(path.join(R, "partitions", f));
const pb = [];
let n = 0, ants = 0, sansTexte = new Set();
const opts = { propreOP: true };
for (const an of [2027, 2028, 2029, 2030, 2031]) {
  // du mercredi des Cendres au jeudi saint
  const debut = Calendrier.jour(`${an}-01-01`, opts);
  for (let d = Calendrier.deIso(`${an}-02-01`); Calendrier.iso(d) <= `${an}-04-30`; d = Calendrier.plus(d, 1)) {
    const iso = Calendrier.iso(d), j = Calendrier.jour(iso, opts);
    if (!(j.temps === "careme" || j.temps === "semaine sainte" || (j.temps === "triduum" && j.jourSemaine === 4))) continue;
    for (const o of ["lectures", "laudes", "vepres"]) {
      const r = SainteBaume.careme(j, o, opts);
      if (!r) { if (!(j.niveau <= 8 && j.source !== "temporal") && !(o !== "lectures" && j.temps === "triduum") && o !== "vepres") pb.push(`${iso} ${o} : rien dans le livret`); continue; }
      n++;
      if (!r.elements.length) pb.push(`${iso} ${o} : aucun psaume`);
      for (const e of r.elements) {
        if (!P[e.id]) pb.push(`${iso} ${o} : pièce ${e.id} absente du psautier`);
        if (e.ant) { ants++; if (!image(e.ant.f)) pb.push(`${iso} ${o} : image ${e.ant.f} absente`); if (!e.ant.texte) sansTexte.add(e.ant.cote || e.ant.inc); }
      }
      if (o !== "lectures" && !r.repons) pb.push(`${iso} ${o} : pas de répons`);
      if (r.repons) for (const f of r.repons.f) if (!image(f)) pb.push(`${iso} ${o} : image ${f} absente`);
      if (o === "lectures" && !r.verset) pb.push(`${iso} lectures : pas de verset`);
    }
  }
}
// temps ordinaire : répartition « Antiennes des offices Ste Baume » (2027)
let to = 0, toAnt = 0, toSansImage = new Set();
for (let d = Calendrier.deIso("2027-01-01"); Calendrier.iso(d) <= "2027-12-31"; d = Calendrier.plus(d, 1)) {
  const iso = Calendrier.iso(d), j = Calendrier.jour(iso, opts);
  for (const o of ["lectures", "laudes", "vepres"]) {
    const r = SainteBaume.ordinaire(j, o, opts);
    if (!r) continue;
    to++;
    if (r.elements.length < (o === "lectures" ? 1 : 2) || r.elements.length > 3) pb.push(`${iso} ${o} (TO) : ${r.elements.length} pièce(s)`);
    for (const e of r.elements) {
      if (e.id !== "AT" && !P[e.id]) pb.push(`${iso} ${o} (TO) : ${e.id} absent du psautier`);
      if (!e.ant) continue;
      toAnt++;
      for (const f of [].concat(e.ant.f || e.ant.sb || [])) if (!image(f)) pb.push(`${iso} ${o} (TO) : image ${f} absente`);
      if (!e.ant.f && !e.ant.sb) toSansImage.add(e.ant.inc);
    }
  }
}
console.log(`Temps ordinaire : ${to} offices, ${toAnt} antiennes ; sans partition : ${[...toSansImage].join(", ") || "aucune"}`);
// milieu du jour : toute l'année 2027
let m = 0;
for (let d = Calendrier.deIso("2027-01-01"); Calendrier.iso(d) <= "2027-12-31"; d = Calendrier.plus(d, 1)) {
  const iso = Calendrier.iso(d), j = Calendrier.jour(iso, opts), r = SainteBaume.milieu(j);
  if (!r) continue;
  m++;
  for (const id of r.ps) if (!P[id]) pb.push(`${iso} milieu : ${id} absent du psautier`);
  if (!r.groupes?.every((g) => g.ant)) pb.push(`${iso} milieu : pas d'antienne`);
  for (const g of r.groupes || []) { if (g.ant && !image(g.ant.f)) pb.push(`${iso} milieu : image ${g.ant.f} absente`); for (const id of g.ps) if (!P[id]) pb.push(`${iso} milieu : ${id} absent`); }
  if (!r.verset) pb.push(`${iso} milieu : pas de verset`);
}
for (const s of SB.vigile) for (const e of s.elements) if (e.f && !image(e.f)) pb.push(`vigile : image ${e.f} absente`);
for (const x of pb.slice(0, 40)) console.log("  " + x);
console.log(`Antiennes sans texte (partition seule) : ${[...sansTexte].join(", ") || "aucune"}`);
console.log(`Sainte-Baume : ${n} offices de Carême (${ants} antiennes), ${m} jours de milieu du jour : ${pb.length} problème(s).`);
process.exit(pb.length ? 1 : 0);
