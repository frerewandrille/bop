// Propre de l'Ordre des carnets du sanctoral (site/donnees/offices_op.json, outils/offices_op.py) :
// chaque psaume existe dans le psautier, chaque image existe, chaque antienne a son texte ; sur deux ans, chaque
// fête de l'Ordre des carnets reçoit son office (laudes, vêpres ; premières vêpres et vigiles de saint Dominique).
const fs = require("fs"), path = require("path"); const R = path.join(__dirname, "..");
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, f)));
globalThis.Textes = { esc: (x) => x };
for (const f of ["calendrier", "propreop"]) require(path.join(R, "site/js", f + ".js"));
const { Calendrier: K, PropreOP: P } = globalThis;
K.charger(lire("site/donnees/sanctoral.json"), lire("site/donnees/propre_op.json"));
const O = lire("site/donnees/offices_op.json"); P.chargerOffices(O);
const pieces = lire("site/donnees/psautier.json").pieces;
const pb = [];
const imgs = (x) => [...JSON.stringify(x).matchAll(/"((?:op|sanctoral\d)\/[^"]+\.jpg)"/g)].map((m) => m[1]);
for (const [cle, e] of Object.entries(O)) {
  for (const [off, o] of Object.entries(e.offices)) {
    for (const el of o.psalmodie || []) {
      if (!el.ant && !(el.ps || []).every((p) => /^NT/.test(p))) pb.push(`${cle} ${off} : antienne sans texte`);
      for (const p of el.ps || []) { const [id, v] = p.split(":"); if (!pieces[id]) pb.push(`${cle} ${off} : psaume ${p} absent du psautier`); if (v && !/^\d+-\d+$/.test(v)) pb.push(`${cle} ${off} : versets « ${v} »`); }
      if (!o.ferie && !(el.ps || []).length) pb.push(`${cle} ${off} : élément sans psaume`);
    }
    if (!(o.psalmodie || []).length) pb.push(`${cle} ${off} : pas de psalmodie`);
    for (const f of imgs(o)) if (!fs.existsSync(path.join(R, "partitions", f))) pb.push(`${cle} ${off} : image absente ${f}`);
  }
}
// sur deux ans : chaque fête trouvée (les mémoires au choix et l'anniversaire : en les choisissant)
const vus = new Set();
for (let d = K.deIso("2026-11-29"); d <= K.deIso("2028-12-01"); d = K.plus(d, 1)) {
  const iso = K.iso(d), mmjj = iso.slice(5);
  const opts = { propreOP: true, ...(O[mmjj] ? { choix: `op-${mmjj}` } : {}) };
  const j = K.jour(iso, opts);
  for (const office of ["laudes", "vepres", "lectures"]) {
    const c = P.carnet(j, office, opts);
    if (c) vus.add(`${c.cle}|${c.premieres ? "vepres1" : office}`);
  }
}
for (const [cle, e] of Object.entries(O)) for (const off of Object.keys(e.offices)) if (!vus.has(`${cle}|${off}`)) pb.push(`${cle} ${off} : jamais proposé sur deux ans`);
for (const p of pb) console.log("  " + p);
console.log(`Propre de l'Ordre (carnets) : ${Object.keys(O).length} fêtes, ${vus.size} offices rencontrés : ${pb.length} problème(s).`);
process.exit(pb.length ? 1 : 0);
