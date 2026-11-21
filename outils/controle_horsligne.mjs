// node outils/controle_horsligne.mjs [jours] [version]
// Contrôle de la lecture hors connexion, dans un vrai navigateur (Brave ou Chrome, sans fenêtre) :
//   1. ouvre le site servi par outils/serveur.py, attend le service worker ;
//   2. enregistre N jours (7 par défaut) dans la version donnée (romaine, province-partitions, gouzantine, latin) ;
//   3. arrête le serveur et coupe le réseau du navigateur ;
//   4. recharge la page et affiche des offices de la période : ils doivent venir de l'appareil.
// Il faut internet au départ (les textes viennent de l'AELF).
import { spawn } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath } from "node:url";

const RACINE = path.dirname(path.dirname(fileURLToPath(import.meta.url)));
const jours = +(process.argv[2] || 7), version = process.argv[3] || "romaine";
const VERSIONS = { romaine: ["romaine", false], province: ["romaine-gouzes", true], "province-partitions": ["romaine-gouzes", true], "sainte-baume": ["sainte-baume", true], gouzantine: ["gouzantine", true], latin: ["latin", true] };
const NAV = ["/Applications/Brave Browser.app/Contents/MacOS/Brave Browser", "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"].find((x) => fs.existsSync(x));
const portSite = 8800 + Math.floor(Math.random() * 100), port = 9333 + Math.floor(Math.random() * 500);
const attendre = (ms) => new Promise((r) => setTimeout(r, ms));

const serveur = spawn("python3", [path.join(RACINE, "outils/serveur.py"), String(portSite), "--sans-navigateur"], { stdio: "ignore" });
const profil = fs.mkdtempSync(path.join(os.tmpdir(), "brev-hl-"));
const nav = spawn(NAV, ["--headless=new", "--disable-gpu", `--remote-debugging-port=${port}`, `--user-data-dir=${profil}`, "--no-first-run", "about:blank"], { stdio: "ignore" });
const fin = (code) => { try { serveur.kill(); } catch {} try { nav.kill(); } catch {} process.exit(code); };

let cibles;
for (let i = 0; i < 60; i++) { try { cibles = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json(); break; } catch { await attendre(300); } }
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
const officePret = async () => { for (let i = 0; i < 80; i++) { if (await js(`return !!document.querySelector("#office article, #office .avertissement")`)) return; await attendre(500); } throw new Error("la page ne s'affiche pas"); };

let echecs = 0;
const verifier = (ok, quoi) => { console.log(`${ok ? "  ok " : "  ÉCHEC "} ${quoi}`); if (!ok) echecs++; };
try {
  await cmd("Page.enable"); await cmd("Network.enable");
  await cmd("Page.navigate", { url: `http://localhost:${portSite}/` });
  await officePret();
  verifier(await js(`await navigator.serviceWorker.ready; for (let i = 0; i < 40 && !navigator.serviceWorker.controller; i++) await new Promise((r) => setTimeout(r, 250)); return !!navigator.serviceWorker.controller;`), "service worker installé et actif");

  const [repartition, partitions] = VERSIONS[version];
  const bilan = await js(`const a = HorsLigne.aujourdhui();
    return await HorsLigne.enregistrer(a, HorsLigne.decaler(a, ${jours - 1}), Object.keys(Offices.OFFICES),
      { propreOP: true, repartition: ${JSON.stringify(repartition)}, partitions: ${partitions}, invitatoire: true, capitules: true, choix: {} }, ${JSON.stringify(version)});`);
  console.log(`Enregistré du ${bilan.debut} au ${bilan.fin} (${version}) : ${bilan.offices} offices, ${bilan.images} partitions ; place : ${await js("return await HorsLigne.occupation()")} Mo`);
  verifier(!bilan.manques.length, `aucun office manquant${bilan.manques.length ? " — " + bilan.manques.join(", ") : ""}`);
  verifier(!bilan.echecsImages && !bilan.echecsFichiers, `aucun fichier manquant (${bilan.echecsImages} partitions, ${bilan.echecsFichiers} fichiers)`);
  await js(`const p = JSON.parse(localStorage.getItem("breviaire-pref") || "{}"); p.repartition = ${JSON.stringify(repartition)}; p.partitions = ${partitions}; localStorage.setItem("breviaire-pref", JSON.stringify(p));`);

  // coupure : plus de serveur, plus de réseau
  serveur.kill(); await attendre(800);
  await cmd("Network.emulateNetworkConditions", { offline: true, latency: 0, downloadThroughput: -1, uploadThroughput: -1 });
  const dernier = bilan.fin, milieu = await js(`return HorsLigne.decaler(HorsLigne.aujourdhui(), ${Math.floor(jours / 2)})`);
  // rechargement complet sans réseau : la page doit revenir de l'appareil
  await js(`window.__avant = 1`);
  await cmd("Page.reload");
  for (let i = 0; i < 60; i++) { await attendre(500); try { if (await js(`return window.__avant !== 1 && !!window.HorsLigne && !!document.querySelector("#office article, #office .avertissement")`)) break; } catch {} }
  verifier(await js(`return window.__avant !== 1 && !!window.Offices && navigator.onLine === false`), "page rechargée sans réseau");
  const aller = async (date, office) => {
    await js(`location.hash = "#${date}/${office}"`);
    for (let i = 0; i < 80; i++) { await attendre(400); if (await js(`return document.querySelector("#date").value === "${date}" && !document.querySelector("#office .chargement") && !!document.querySelector("#office article, #office .avertissement")`)) return; }
    throw new Error("office non affiché");
  };
  for (const [date, office] of [[milieu, "laudes"], [dernier, "vepres"], [dernier, "lectures"], [milieu, "complies"], [milieu, "milieu"]]) {
    await aller(date, office);
    const r = await js(`const o = document.querySelector("#office"); const imgs = [...o.querySelectorAll("img")].map((i) => i.getAttribute("src"));
      let imagesOk = 0; for (const s of imgs) { try { if ((await fetch(s)).ok) imagesOk++; } catch (e) {} }
      return { titre: o.querySelector("h2")?.textContent || "", psaumes: o.querySelectorAll(".psaume").length, erreur: (o.querySelector("p.avertissement")?.textContent || "").slice(0, 120), longueur: o.textContent.length, images: imgs.length, imagesOk };`);
    if (version === "latin" && office === "lectures") continue;   // les Heures grégoriennes n'ont pas cet office
    verifier((version === "latin" ? r.longueur > 3000 : r.psaumes > 0) && !r.erreur && r.images === r.imagesOk, `${date} ${r.titre} sans réseau : ${r.psaumes} psaumes, ${r.longueur} caractères, ${r.imagesOk}/${r.images} partitions${r.erreur ? " — " + r.erreur : ""}`);
  }
  if (version !== "latin") {   // la version latine ne dépend pas de l'AELF
  // hors de la période : le message doit le dire
  const loin = await js(`return HorsLigne.decaler(HorsLigne.aujourdhui(), ${jours + 40})`);
  await aller(loin, "laudes");
  const msg = await js(`return document.querySelector("#office").textContent.slice(0, 300)`);
  verifier(/hors connexion/.test(msg), `${loin} (non enregistré) : message « hors connexion »`);
  }
} catch (e) { console.log("  ÉCHEC", e.message); echecs++; }
console.log(echecs ? `${echecs} problème(s).` : "Hors connexion : 0 problème.");
fin(echecs ? 1 : 0);
