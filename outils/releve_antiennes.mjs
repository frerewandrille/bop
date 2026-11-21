// node outils/releve_antiennes.mjs <url d'impression avec &apercu> <sortie.json>
// Contrôle des antiennes : ouvre une page du bréviaire dans Brave (ou Chrome) sans fenêtre, attend qu'elle soit
// prête (body[data-pret="1"]) et relève, sous chaque psaume, les images de partitions posées dessous.
// Le relevé est ensuite lu par : python3 outils/controle_antiennes.py sortie.json
import { spawn } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";

const [url, sortie] = process.argv.slice(2);
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
await cmd("Page.navigate", { url });
for (let i = 0; i < 240; i++) {
  const r = await cmd("Runtime.evaluate", { expression: "document.body && document.body.dataset.pret", returnByValue: true });
  if (r.result?.result?.value === "1") break;
  await attendre(500);
}
await attendre(1500);
{
  // relevé : pour chaque office, chaque élément de psalmodie : psaumes du texte et images de partition posées dessous
  const expr = `JSON.stringify([...document.querySelectorAll("article.office")].map(a => ({
    office: a.className, date: a.querySelector(".date-longue")?.textContent || "", nom: a.querySelector(".celebration")?.textContent.trim() || "",
    elts: [...a.querySelectorAll(".psalmodie-element")].map(e => ({ ids: [...e.querySelectorAll("[data-piece]")].map(x => x.dataset.piece),
      ant: (e.querySelector(".antienne")?.textContent || "").slice(0, 60), imgs: [...e.querySelectorAll("img")].map(i => i.getAttribute("src").replace("partitions/", "")) })),
    autres: [...a.querySelectorAll(".partitions-autres img")].map(i => i.getAttribute("src").replace("partitions/", ""))
  })))`;
  const r = await cmd("Runtime.evaluate", { expression: expr, returnByValue: true });
  fs.writeFileSync(sortie, r.result.result.value);
}
console.log("écrit :", sortie);
ws.close(); p.kill(); process.exit(0);
