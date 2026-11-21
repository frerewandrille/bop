// Relève les images de partitions réellement affichées par le site, pour ne publier qu'elles sur Azure.
//   node outils/releve_images.mjs [années]        (4 par défaut, depuis l’Avent de l’année en cours : cycles A, B, C et une de plus)
// Construit dans un vrai navigateur (Brave ou Chrome, sans fenêtre) chaque office de chaque jour, dans les
// versions avec partitions (Province avec partitions, Sainte-Baume, gouzantine, latin-français), à l'écran et à l'impression,
// avec et sans le propre de l'Ordre, et, les jours où l'on peut choisir entre le saint et la férie, avec chaque
// choix. Écrit partitions/images-utilisees.json, lu par outils/publier_azure.sh.
// Il faut internet (les textes viennent de l'AELF) ; compter 20 à 40 minutes.
import { spawn } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const RACINE = path.dirname(path.dirname(fileURLToPath(import.meta.url)));
const ANNEES = +(process.argv[2] || 4);
const SORTIE = path.join(RACINE, "partitions/images-utilisees.json");
const DEPART = new Date();   // la liste est datée du début : un fichier modifié pendant le relevé la rend « ancienne »
const VERSIONS = { province: "romaine-gouzes", "province-partitions": "romaine-gouzes", "sainte-baume": "sainte-baume", gouzantine: "gouzantine", latin: "latin" };
const NAV = ["/Applications/Brave Browser.app/Contents/MacOS/Brave Browser", "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"].find((x) => fs.existsSync(x));
if (!NAV) { console.error("Ni Brave ni Chrome trouvé dans /Applications."); process.exit(1); }
const portSite = 8900 + Math.floor(Math.random() * 80), port = 9500 + Math.floor(Math.random() * 400);
const attendre = (ms) => new Promise((r) => setTimeout(r, ms));
const serveur = spawn("python3", [path.join(RACINE, "outils/serveur.py"), String(portSite), "--sans-navigateur"], { stdio: "ignore" });
const profil = fs.mkdtempSync(path.join(os.tmpdir(), "brev-releve-"));
const nav = spawn(NAV, ["--headless=new", "--disable-gpu", `--remote-debugging-port=${port}`, `--user-data-dir=${profil}`, "--no-first-run", "about:blank"], { stdio: "ignore" });
const fin = (c) => { try { serveur.kill(); } catch {} try { nav.kill(); } catch {} try { fs.rmSync(profil, { recursive: true, force: true }); } catch {} process.exit(c); };

let cibles;
for (let i = 0; i < 60; i++) { try { cibles = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json(); break; } catch { await attendre(300); } }
if (!cibles) { console.error("Le navigateur ne répond pas."); fin(1); }
const ws = new WebSocket(cibles.find((c) => c.type === "page").webSocketDebuggerUrl);
await new Promise((r) => ws.addEventListener("open", r));
let id = 0; const att = new Map();
ws.addEventListener("message", (e) => { const m = JSON.parse(e.data); if (m.id && att.has(m.id)) { att.get(m.id)(m); att.delete(m.id); } });
const cmd = (method, params = {}) => new Promise((r) => { const i = ++id; att.set(i, r); ws.send(JSON.stringify({ id: i, method, params })); });
const js = async (expression) => {
  const r = await cmd("Runtime.evaluate", { expression: `(async () => { ${expression} })()`, awaitPromise: true, returnByValue: true });
  if (r.result?.exceptionDetails) throw new Error(r.result.exceptionDetails.exception?.description || "erreur dans la page");
  return r.result.result.value;
};
await attendre(800);
await cmd("Page.navigate", { url: `http://localhost:${portSite}/index.html` });
let pret = false;
for (let i = 0; i < 160 && !pret; i++) { try { pret = await js(`return !!document.querySelector("#office article, #office section, #office .avertissement") && !!(window.Partitions && Partitions.index)`); } catch {} if (!pret) await attendre(250); }
if (!pret) { console.error("Le site ne s'ouvre pas (partitions/index.json absent ?)."); fin(1); }

// période : du 1er dimanche de l'Avent de l'année liturgique en cours, sur N années
const debut = await js(`const C = Calendrier, a = new Date().getFullYear();
  for (let y = a; y >= a - 1; y--) { let d = C.deIso(y + "-11-27"); while (C.jour(C.iso(d)).jourSemaine !== 0) d = C.plus(d, 1); if (C.iso(d) <= C.iso(new Date())) return C.iso(d); }
  return (a - 1) + "-11-27";`);
const finP = await js(`const C = Calendrier; return C.iso(C.plus(C.deIso("${debut}"), ${ANNEES} * 364 + 7));`);
console.log(`Relevé du ${debut} au ${finP}, ${Object.keys(VERSIONS).length} versions.`);

const images = new Map();
let erreurs = 0, offices = 0;
for (const [version, repartition] of Object.entries(VERSIONS)) {
  const t0 = Date.now();
  const r = await js(`
    const vus = {}, err = [];
    let n = 0;
    const noter = (html) => { for (const m of html.matchAll(/src="(partitions\\/[^"?]+)/g)) vus[m[1]] = (vus[m[1]] || 0) + 1; };
    const C = Calendrier, OFF = ["lectures", "laudes", "milieu", "vepres", "complies"];
    const base = { repartition: "${repartition}", invitatoire: true, prieres: false, partitions: true, partitionsOuvertes: true, capitules: true, oraison: "liturgique" };
    Partitions.ouvertes = true;
    async function faire(s, o, opts) {
      for (const impression of [false, true]) {
        try { const x = await Offices.construire(s, o, { ...base, ...opts, impression }); noter(x.html); n++; }
        catch (e) { err.push(s + " " + o + " : " + e.message); }
      }
    }
    for (let d = C.deIso("${debut}"); C.iso(d) <= "${finP}"; d = C.plus(d, 1)) {
      const s = C.iso(d);
      for (const propreOP of [true, false]) {
        for (const o of OFF) await faire(s, o, { propreOP, choix: {} });
        // jours où l'on peut choisir le saint ou la férie : chaque choix
        const j = C.jour(s, { propreOP });
        for (const c of j.choixPossibles || []) if (c.cle !== j.choix) for (const o of OFF) await faire(s, o, { propreOP, choix: { [s]: c.cle } });
        // veille : les vêpres de la veille dépendent du choix du lendemain
        const dem = C.iso(C.plus(d, 1)), jd = C.jour(dem, { propreOP });
        for (const c of jd.choixPossibles || []) if (c.cle !== jd.choix) await faire(s, "vepres", { propreOP, choix: { [dem]: c.cle } });
      }
    }
    return { vus, err: err.slice(0, 20), nerr: err.length, n };`);
  for (const [k, v] of Object.entries(r.vus)) images.set(k, (images.get(k) || 0) + v);
  erreurs += r.nerr; offices += r.n;
  console.log(`  ${version} : ${Object.keys(r.vus).length} images, ${r.n} offices, ${r.nerr} erreur(s) — ${Math.round((Date.now() - t0) / 60000)} min`);
  for (const e of r.err) console.log("    " + e);
}
if (erreurs) { console.error(`${erreurs} office(s) n'ont pas pu être construits (réseau ? AELF ?) : liste non écrite. Relancez.`); fin(1); }
// communs des saints : choisis à la main n'importe quel jour (bouton « Communs ») — toutes leurs partitions
try {
  const C = fs.readFileSync(path.join(RACINE, "partitions/hg/communs.json"), "utf8");
  for (const f of C.match(/"hg\d\/[^"]+\.jpg"/g) || []) images.set("partitions/" + f.slice(1, -1), true);
} catch { /* pas de communs */ }
// livrets de Sainte-Baume : toutes leurs partitions (Veillée pascale de la page Messe, hymnes au choix…)
try {
  const S = fs.readFileSync(path.join(RACINE, "site/donnees/sainte_baume.json"), "utf8");
  for (const f of S.match(/"ly\/[^"]+\.png"/g) || []) images.set("partitions/" + f.slice(1, -1), true);
} catch { /* pas de livrets */ }
// propre de l'Ordre des carnets du sanctoral : toutes ses partitions (mémoires au choix, antiennes « ou bien »…)
try {
  const O = fs.readFileSync(path.join(RACINE, "site/donnees/offices_op.json"), "utf8");
  for (const f of O.match(/"(?:op|sanctoral\d)\/[^"]+\.jpg"/g) || []) images.set("partitions/" + f.slice(1, -1), true);
} catch { /* pas de propre */ }
const liste =[...new Set([...images.keys()].map((x) => x.replace(/^partitions\//, "")))].sort();
const manquantes = liste.filter((f) => !fs.existsSync(path.join(RACINE, "partitions", f)));
fs.writeFileSync(SORTIE, JSON.stringify({ releve: DEPART.toISOString(), debut, fin: finP, versions: Object.keys(VERSIONS), offices, images: liste }, null, 0));
fs.utimesSync(SORTIE, DEPART, DEPART);
console.log(`${liste.length} images utilisées → partitions/images-utilisees.json`);
if (manquantes.length) console.log(`Attention : ${manquantes.length} image(s) demandée(s) par le site mais absente(s) du dossier : ${manquantes.slice(0, 10).join(", ")}`);
fin(0);
