/* Essai local de la connexion : node outils/essai_connexion.js [port]
   Sert le dossier site/ et le service api/connexion (comptes gardés en mémoire, perdus à l'arrêt).
   Clé d'administration de l'essai : essai-local-1234.
   Pages : http://localhost:8791/comptes.html
           http://localhost:8791/api/connexion/authorize?client_id=breviaire&redirect_uri=http://localhost:8791/.auth/login/breviaire/callback&response_mode=form_post&state=x
   (La porte d'Azure n'est pas imitée : le retour /.auth/login/…/callback affiche seulement ce qu'Azure recevrait.) */
const http = require("http"), fs = require("fs"), path = require("path"), crypto = require("crypto");
const PORT = Number(process.argv[2] || 8791);
const SITE = path.join(__dirname, "..", "site");

const { privateKey } = crypto.generateKeyPairSync("rsa", { modulusLength: 2048 });
Object.assign(process.env, {
  CONNEXION_CLE_PRIVEE: privateKey.export({ type: "pkcs8", format: "pem" }),
  CONNEXION_CLIENT_ID: "breviaire", CONNEXION_CLIENT_SECRET: "essai", CONNEXION_ADMIN_CLE: "essai-local-1234",
  CONNEXION_EMETTEUR: `http://localhost:${PORT}/api/connexion`,
});
const service = require("../api/connexion/index.js");
const table = new Map();
service.utiliserDepot({
  async lire(id) { return table.has(id) ? { ...table.get(id) } : null; },
  async ecrire(e) { table.set(e.RowKey, { ...e }); },
  async effacer(id) { table.delete(id); },
  async lister() { return [...table.values()]; },
});
const TYPES = { ".html": "text/html; charset=utf-8", ".js": "text/javascript", ".css": "text/css", ".json": "application/json", ".svg": "image/svg+xml", ".png": "image/png", ".woff2": "font/woff2", ".webmanifest": "application/manifest+json" };

http.createServer(async (rq, rs) => {
  const u = new URL(rq.url, `http://localhost:${PORT}`);
  let corps = ""; for await (const c of rq) corps += c;
  if (u.pathname.startsWith("/api/connexion/")) {
    const ctx = {};
    const req = { method: rq.method, params: { chemin: u.pathname.slice("/api/connexion/".length) }, query: Object.fromEntries(u.searchParams), headers: rq.headers, rawBody: corps };
    if (/json/.test(rq.headers["content-type"] || "")) { try { req.body = JSON.parse(corps); } catch (e) { /* rien */ } } else req.body = corps;
    await service(ctx, req);
    const h = { ...(ctx.res.headers || {}) };
    if (h["Set-Cookie"]) h["Set-Cookie"] = h["Set-Cookie"].replace("; Secure", "");   // http local
    rs.writeHead(ctx.res.status || 200, h); rs.end(ctx.res.body || ""); return;
  }
  if (u.pathname.startsWith("/.auth/login/breviaire/callback")) {
    rs.writeHead(200, { "Content-Type": "text/html; charset=utf-8" });
    rs.end(`<!doctype html><meta charset="utf-8"><body style="font:16px sans-serif;padding:24px"><h1>Azure recevrait ici :</h1><pre style="white-space:pre-wrap;word-break:break-all">${corps.replace(/</g, "&lt;")}</pre><p><a href="/api/connexion/deconnexion">Oublier cet appareil</a></p>`);
    return;
  }
  let f = path.join(SITE, decodeURIComponent(u.pathname));
  if (!f.startsWith(SITE)) { rs.writeHead(403); rs.end(); return; }
  if (fs.existsSync(f) && fs.statSync(f).isDirectory()) f = path.join(f, "index.html");
  if (!fs.existsSync(f)) { rs.writeHead(404); rs.end("introuvable"); return; }
  rs.writeHead(200, { "Content-Type": TYPES[path.extname(f)] || "application/octet-stream" });
  fs.createReadStream(f).pipe(rs);
}).listen(PORT, "127.0.0.1", () => console.log(`Essai de connexion : http://localhost:${PORT}/comptes.html (clé essai-local-1234)`));
