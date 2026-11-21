// Audit des partitions des carnets du temps : pour chaque jour d'une année liturgique, ce que le site retient
// à laudes, vêpres et vigiles (hymne, antiennes, répons…), et les manques.
//   node outils/audit_partitions.js [début AAAA-MM-JJ] [fin] [--hymnes] [--tout]
const fs = require("fs"), path = require("path"); const R = path.join(__dirname, "..");
const lire = (f) => JSON.parse(fs.readFileSync(path.join(R, f)));
globalThis.Textes = { esc: (x) => x };
for (const f of ["calendrier", "partitions"]) require(path.join(R, "site/js", f + ".js"));
const { Calendrier: K, Partitions: P } = globalThis;
K.charger(lire("site/donnees/sanctoral.json"), lire("site/donnees/propre_op.json"));
const I = lire("partitions/index.json");
globalThis.fetch = async (u) => { const f = path.join(R, u); return fs.existsSync(f) ? { ok: true, json: async () => lire(u) } : { ok: false }; };
const a = process.argv.slice(2).filter((x) => !x.startsWith("--"));
const HYMNES = process.argv.includes("--hymnes"), TOUT = process.argv.includes("--tout");
(async () => {
  await P.charger();
  const opts = { propreOP: true };
  const lignes = new Map(), manques = new Map();
  for (let d = K.deIso(a[0] || "2026-11-29"); d <= K.deIso(a[1] || "2027-11-27"); d = K.plus(d, 1)) {
    const j = K.jour(K.iso(d), opts);
    for (const office of ["laudes", "vepres", "lectures"]) {
      if (office === "lectures" && j.jourSemaine !== 0) continue;
      if (P.ordoPour(j, office, opts)) continue;                 // sanctoral : voir tests/sanctoral.test.js
      if (j.niveau <= 8 && j.source !== "temporal") continue;
      const l = P.pour(j, office);
      const par = {};
      for (const x of l) (par[x.role] ||= []).push(`${x.carnet} p.${x.pages[0]}${x.pages.length > 1 ? "-" + x.pages[x.pages.length - 1] : ""} « ${x.titre} »`);
      const cle = `${P.cleJour(j)}|${office}`;
      const m = [];
      if (!par.hymne && !par.lucernaire) m.push("sans hymne");
      const nh = l.filter((x) => x.role === "hymne" && !x.alt).length; if (nh > 2) m.push(`${nh} hymnes (hors « au choix »)`);
      if (!par.antiennes) m.push("sans antiennes");
      if ((par.antiennes || []).length > 2) m.push(`${par.antiennes.length} pages d'antiennes`);
      if (!par.repons && office !== "lectures") m.push("sans répons");
      if ((par.repons || []).length > 1) m.push(`${par.repons.length} répons`);
      if (office === "vepres" && !par.cantique) m.push("sans cantique NT");
      if (m.length) manques.set(cle, `${j.date} ${j.nom.slice(0, 40)} : ${m.join(", ")}`);
      const h = (par.lucernaire || []).map((x) => "LUC " + x).concat(par.hymne || []).join(" + ") || "—";
      lignes.set(cle, HYMNES ? h : Object.entries(par).map(([r, v]) => `${r}: ${v.join(" + ")}`).join(" ; "));
    }
  }
  if (HYMNES || TOUT) for (const [k, v] of lignes) console.log(`${k} → ${v}`);
  console.log(`\n${manques.size} office(s) avec un manque ou un doublon :`);
  for (const [k, v] of manques) console.log(`  ${k} — ${v}`);
})();
