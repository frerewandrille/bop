// Communs des saints (Heures grégoriennes, tome III) : pour chaque commun, chaque office, chaque précision et
// trois temps (ordinaire, Carême, temps pascal), les pièces sont là, et chaque psaume et chaque lecture
// brève se retrouvent dans le psautier et la Bible de Jérusalem.
//   node tests/communs.test.js [-v]
const fs = require("fs");
const path = require("path");
const R = path.join(__dirname, "..");
const bavard = process.argv.includes("-v");
globalThis.fetch = async (url) => {
  url = String(url);
  const f = url.startsWith("partitions/") ? path.join(R, url) : path.join(R, "site", url);
  if (!fs.existsSync(f)) return { ok: false, json: async () => null };
  const t = fs.readFileSync(f, "utf8");
  return { ok: true, json: async () => JSON.parse(t) };
};
for (const f of ["calendrier", "textes", "communs"]) require(path.join(R, "site/js", f + ".js"));
const { Psautier, Bible, Communs } = globalThis;

(async () => {
  await Psautier.charger("donnees/psautier.json");
  if (!(await Communs.charger())) { console.log("partitions/hg/communs.json absent : test sauté."); return; }
  const jours = [
    { date: "2027-07-13", temps: "ordinaire", niveau: 10, jourSemaine: 2 },
    { date: "2027-03-02", temps: "careme", niveau: 10, jourSemaine: 2 },
    { date: "2027-05-04", temps: "paques", niveau: 10, jourSemaine: 2 },
    { date: "2027-07-13", temps: "ordinaire", niveau: 7, jourSemaine: 2 },
  ];
  const pb = [];
  let n = 0;
  const vus = new Set();
  for (const c of Communs.liste) for (const office of ["laudes", "milieu", "vepres", "vepres1"]) for (const pour of [null, ...c.precisions]) for (const j of jours) {
    const r = Communs.pour({ id: c.id, pour }, j, office);
    const nom = `${c.id}${pour ? " (" + pour + ")" : ""} ${office} ${j.temps}`;
    if (!r) { if (office !== "milieu" || !["docteurs", "plusieurs-saints"].includes(c.id)) pb.push(`${nom} : rien`); continue; }
    n++;
    if (office !== "milieu") {
      if (!r.psaumes?.length || r.antiennes?.length < 3) pb.push(`${nom} : psalmodie incomplète (${r.psaumes?.length || 0} psaumes, ${r.antiennes?.length || 0} antiennes)`);
      for (const k of ["lecture", "repons", "evangelique", "preces"]) if (!r[k]) pb.push(`${nom} : pas de ${k}`);
      if (c.id === "defunts" && office !== "laudes" && office !== "vepres") continue;
    } else if (r.milieu?.length !== 3) pb.push(`${nom} : ${r.milieu?.length || 0} capitules au milieu du jour`);
    if (j.temps === "careme" && JSON.stringify(r).includes("Alléluia")) pb.push(`${nom} : alléluia en Carême`);
    for (const a of r.antiennes || []) if (/T\.\s?P\./.test(a.texte)) pb.push(`${nom} : « T.P. » resté dans « ${a.texte} »`);
    for (const ref of r.psaumes || []) {
      if (vus.has(ref)) continue; vus.add(ref);
      if (!Psautier.trouver(ref, [])) pb.push(`${nom} : psaume « ${ref} » introuvable`);
    }
    for (const ref of [r.lecture?.ref, ...(r.milieu || []).map((m) => m.ref)].filter(Boolean)) {
      if (vus.has("L" + ref)) continue; vus.add("L" + ref);
      const b = await Bible.lire(ref);
      if (!b || !b.html || b.manquants?.length) pb.push(`${nom} : lecture « ${ref} » ${b ? "incomplète (" + b.manquants.join(", ") + ")" : "illisible"}`);
    }
    if (bavard) console.log(nom, "→", (r.psaumes || []).join(", "), "|", r.lecture?.ref || r.milieu?.map((m) => m.ref).join(", "));
  }
  for (const p of pb) console.log("  " + p);
  console.log(`Communs : ${Communs.liste.length} communs, ${n} offices construits, ${pb.length} problème(s).`);
  if (pb.length) process.exitCode = 1;
})();
