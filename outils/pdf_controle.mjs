// node outils/pdf_controle.mjs <url> <sortie.pdf|.docx> ['{"bouchet":{"2027-02-17":["careme-1-3:0:0"]}}']
//   (3e argument facultatif : réglages posés dans localStorage avant le chargement, comme sur l'ordinateur de l'utilisateur)
// Imprime une page du bréviaire avec Brave (ou Chrome) sans fenêtre, via le protocole DevTools,
// après avoir attendu que la page soit prête (body[data-pret="1"]). Sert aux contrôles de rendu.
import { spawn } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";

const [url, sortie, reglages] = process.argv.slice(2);
const NAV = ["/Applications/Brave Browser.app/Contents/MacOS/Brave Browser", "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"].find((x) => fs.existsSync(x));
const port = 9333 + Math.floor(Math.random() * 500);
const profil = fs.mkdtempSync(path.join(os.tmpdir(), "brev-"));
const p = spawn(NAV, ["--headless=new", "--disable-gpu", `--remote-debugging-port=${port}`, `--user-data-dir=${profil}`, "--no-first-run", "about:blank"], { stdio: "ignore" });
const attendre = (ms) => new Promise((r) => setTimeout(r, ms));
let cibles;
for (let i = 0; i < 60; i++) { try { cibles = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json(); break; } catch { await attendre(300); } }
const page = cibles.find((c) => c.type === "page");
const ws = new WebSocket(page.webSocketDebuggerUrl);
await new Promise((r) => ws.addEventListener("open", r));
let id = 0; const att = new Map();
ws.addEventListener("message", (e) => { const m = JSON.parse(e.data); if (m.id && att.has(m.id)) { att.get(m.id)(m); att.delete(m.id); } });
const cmd = (method, params = {}) => new Promise((r) => { const i = ++id; att.set(i, r); ws.send(JSON.stringify({ id: i, method, params })); });
await cmd("Page.enable");
if (reglages) await cmd("Page.addScriptToEvaluateOnNewDocument", { source: `try { localStorage.setItem("breviaire-pref", ${JSON.stringify(reglages)}); } catch (e) {}` });
await cmd("Page.navigate", { url });
for (let i = 0; i < 240; i++) {
  const r = await cmd("Runtime.evaluate", { expression: "document.body && document.body.dataset.pret", returnByValue: true });
  if (r.result?.result?.value === "1") break;
  await attendre(500);
}
await attendre(1500);
if (sortie.endsWith(".docx")) {
  const r = await cmd("Runtime.evaluate", { expression: "window.__docx || ''", returnByValue: true });
  fs.writeFileSync(sortie, Buffer.from(r.result.result.value, "base64"));
} else {
  const r = await cmd("Page.printToPDF", { preferCSSPageSize: true, printBackground: true });
  fs.writeFileSync(sortie, Buffer.from(r.result.data, "base64"));
}
console.log("écrit :", sortie);
ws.close(); p.kill(); process.exit(0);
