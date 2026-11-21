// Version latin-français (Heures grégoriennes) : construit les 4 heures de chaque jour d'une année
// liturgique et relève ce qui manque ou ce qui ne devrait pas paraître (consignes du livre, renvois de page…).
//   node tests/latin.test.js            → résumé
//   node tests/latin.test.js 2027-01-31 milieu   → texte de l'office
const fs = require("fs"), path = require("path"); const R = path.join(__dirname, "..");
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, f)));
globalThis.fetch = async (u) => { const f = path.join(R, u.startsWith("partitions/") ? "" : "site", u.split("?")[0]); return fs.existsSync(f) ? { ok: true, json: async () => JSON.parse(fs.readFileSync(f)) } : { ok: false }; };
for (const f of ["textes", "calendrier", "partitions", "latin"]) require(path.join(R, "site/js", f + ".js"));
const { Calendrier: K, Latin } = globalThis;
K.charger(lire("site/donnees/sanctoral.json"), lire("site/donnees/propre_op.json"));
const texte = (h) => h.replace(/<(br|p|div|h3|h4|section|span class="l)[^>]*>/g, "\n").replace(/<[^>]+>/g, "").replace(/&amp;/g, "&").replace(/\n\s*\n+/g, "\n");
const aide = { entete: (j, o) => `<header>${j.nom} — ${o}</header>`, bloc: (t, c, cl = "") => `<section class="${cl}"><h3>${t}</h3>${c}</section>` };
const ATTENDU = { laudes: ["Hymnus", "Psalmodia", "Lectio brevis", "Responsorium breve", "Canticum evangelicum", "Oratio"],
  vepres: ["Hymnus", "Psalmodia", "Lectio brevis", "Responsorium breve", "Canticum evangelicum", "Oratio"],
  milieu: ["Hymnus", "Psalmodia", "Lectio brevis", "Oratio"], complies: ["Hymnus", "Psalmodia", "Lectio brevis", "Canticum evangelicum", "Oratio"] };
(async () => {
  await globalThis.Partitions.chargerHG?.();
  if (!(await Latin.charger())) { console.log("offices.json absent"); return; }
  const [jour, off] = process.argv.slice(2);
  const opts = { propreOP: true, repartition: "latin", partitions: true };
  if (jour) { const r = Latin.construire(K.jour(jour, { propreOP: true }), off || "laudes", opts, aide); console.log(texte(r.html)); console.log(r.avertissements); return; }
  const pb = {};
  const note = (k, x) => (pb[k] ||= []).push(x);
  for (let d = K.deIso("2026-11-29"); d < K.deIso("2027-11-28"); d = K.plus(d, 1)) {
    const j = K.jour(K.iso(d), { propreOP: true });
    for (const o of ["laudes", "milieu", "vepres", "complies"]) {
      const r = Latin.construire(j, o, opts, aide); const t = texte(r.html); const id = `${j.date} ${o}`;
      const titres = [...r.html.matchAll(/<h3>([^<—]*)/g)].map((m) => m[1].trim());
      for (const a of ATTENDU[o]) if (!titres.includes(a)) note(`${o} sans ${a}`, id);
      for (const m of r.html.matchAll(/<h3>([^<]*)<\/h3>(<\/section>|<div class="bilingue"><div class="la" lang="la"><\/div><div class="fr"><\/div>)/g)) note(`section vide : ${m[1].split(" — ")[0]}`, id);
      const m = t.match(/.{0,30}\b(pp?\.|pages?)\s*\d{2,}.{0,20}/); if (m) note("renvoi au livre", `${id} « ${m[0].replace(/\n/g, " / ")} »`);
      if (/Anno [ABC]:|Année [ABC]:/.test(t)) note("années A/B/C mêlées", id);
      const cm = t.match(/[^\s]{0,12}[a-zà-ÿ]-\n[a-zà-ÿ][^\s]{0,12}/); if (cm) note("mot coupé en fin de ligne", `${id} « ${cm[0].replace("\n", "/")} »`);
      if (/\n(DECEMBER|IANUARIUS|FEBRUARIUS|MARTIUS|APRILIS|MAIUS|IUNIUS|IULIUS|AUGUSTUS|SEPTEMBER|OCTOBER|NOVEMBER)\b|Die \d+ [a-z]+ris|COMPLIES\n/.test(t)) note("titre d'une autre page", id);
      // un psaume divisé en parties (I, II, III) compte pour autant de psaumes
      const psal = (r.html.match(/<section class="psalmodie">[\s\S]*?<\/section>/) || [""])[0];
      const nps = (psal.match(/class="titre-bilingue"/g) || []).length + Math.max(0, ((psal.match(/<p class="titre-ps">(I|II|III|IV)<\/p>/g) || []).length / 2) - 1);
      const nant = (psal.match(/class="antienne-fr"><span class="rubrique">Ant\.(?! \d? ?\(reprise)/g) || []).length;
      if (nps && !nant) note(`${o} : psaumes sans antienne`, id);
      if (o !== "complies" && o !== "milieu" && (nps < 3 || nps > 3)) note(`${o} : ${nps} psaume(s)`, id);
    }
  }
  let ko = 0;
  const tout = process.env.TOUT;
  for (const [k, v] of Object.entries(pb).sort()) { ko += v.length; console.log(`  ${k} : ${v.length} — ${v.slice(0, tout ? 999 : 4).join(tout ? "\n      " : " | ")}`); }
  console.log(`Latin-français : ${ko} remarque(s).`);
})();
