/* Connexion au bréviaire par identifiant et mot de passe (voir docs/CONNEXION.md).

   Ce service joue, pour Azure Static Web Apps, le rôle d'un « fournisseur de comptes » OpenID Connect
   (comme Microsoft ou Google) : Azure garde la porte du site et demande ici qui est le visiteur.

   /api/connexion/.well-known/openid-configuration   description du fournisseur (lue par Azure)
   /api/connexion/authorize    GET : page de connexion, ou réponse immédiate si l'appareil est reconnu
                               POST : identifiant + mot de passe
   /api/connexion/token        POST (Azure) : échange le code contre l'attestation signée (id_token)
   /api/connexion/jwks         clé publique de vérification des attestations
   /api/connexion/userinfo     qui est le porteur de l'attestation
   /api/connexion/deconnexion  oublie cet appareil puis ferme la session Azure
   /api/connexion/comptes      gestion des comptes (en-tête « x-cle » = clé d'administration)
                               GET liste · POST créer · PUT ?id= modifier · DELETE ?id= supprimer

   Réglages de l'application (posés par outils/preparer_connexion.sh) :
     CONNEXION_CLIENT_ID, CONNEXION_CLIENT_SECRET   identité du site auprès de ce service
     CONNEXION_CLE_PRIVEE                           clé RSA (PEM, ou PEM en base64) qui signe les attestations
     CONNEXION_ADMIN_CLE                            clé de la page « Comptes »
     CONNEXION_EMETTEUR  (facultatif)               adresse publique de ce service, ex. https://…/api/connexion
     CONNEXION_SITES     (facultatif)               sites protégés, séparés par des virgules (adresses https://…)
     SIGNALEMENTS_STOCKAGE                          compte de stockage (table « comptes »)
   Aucune dépendance : Node 20, module crypto. */
const crypto = require("crypto");
const { promisify } = require("util");
const scrypt = promisify(crypto.scrypt);

const UN_AN = 365 * 24 * 3600;
const DUREE_CODE = 120;            // secondes pour qu'Azure échange le code
const DUREE_ATTESTATION = 24 * 3600;
const ESSAIS_MAX = 5, BLOCAGE = 15 * 60;
const TEMOIN = "breviaire-compte";
const SCRYPT = { N: 16384, r: 8, p: 1 };

/* ─── Réglages et clés ─── */
let _cles = null;
function cles() {
  if (_cles) return _cles;
  let pem = (process.env.CONNEXION_CLE_PRIVEE || "").trim();
  if (!pem) throw new Error("CONNEXION_CLE_PRIVEE manquante");
  if (!pem.startsWith("-----")) pem = Buffer.from(pem, "base64").toString("utf8");
  pem = pem.replace(/\\n/g, "\n");
  const privee = crypto.createPrivateKey(pem);
  const jwk = crypto.createPublicKey(privee).export({ format: "jwk" });
  const kid = crypto.createHash("sha256").update(jwk.n).digest("base64url").slice(0, 16);
  const hmac = crypto.createHash("sha256").update("breviaire-connexion|" + pem).digest();
  _cles = { privee, jwk: { ...jwk, kid, use: "sig", alg: "RS256" }, kid, hmac };
  return _cles;
}
const clientId = () => process.env.CONNEXION_CLIENT_ID || "breviaire";
const egal = (a, b) => { a = Buffer.from(String(a)); b = Buffer.from(String(b)); return a.length === b.length && a.length > 0 && crypto.timingSafeEqual(a, b); };

function emetteur(req) {
  if (process.env.CONNEXION_EMETTEUR) return process.env.CONNEXION_EMETTEUR.replace(/\/$/, "");
  const h = req.headers || {};
  const orig = h["x-ms-original-url"];
  if (orig) { try { return new URL(orig).origin + "/api/connexion"; } catch (e) { /* suite */ } }
  const hote = String(h["x-forwarded-host"] || h.host || "localhost").split(",")[0].trim();
  const proto = String(h["x-forwarded-proto"] || (/^localhost|^127\./.test(hote) ? "http" : "https")).split(",")[0].trim();
  return `${proto}://${hote}/api/connexion`;
}

/* ─── Jetons signés (témoin de l'appareil, code d'échange) : données en base64url + HMAC ─── */
const b64 = (o) => Buffer.from(JSON.stringify(o)).toString("base64url");
function signer(o) { const d = b64(o); return d + "." + crypto.createHmac("sha256", cles().hmac).update(d).digest("base64url"); }
function lireSigne(t) {
  const [d, s] = String(t || "").split(".");
  if (!d || !s || !egal(s, crypto.createHmac("sha256", cles().hmac).update(d).digest("base64url"))) return null;
  try { const o = JSON.parse(Buffer.from(d, "base64url").toString()); return o.exp && o.exp > maintenant() ? o : null; } catch (e) { return null; }
}
const maintenant = () => Math.floor(Date.now() / 1000);

function jwt(claims) {
  const tete = b64({ alg: "RS256", typ: "JWT", kid: cles().kid });
  const corps = b64(claims);
  const sig = crypto.sign("sha256", Buffer.from(`${tete}.${corps}`), cles().privee).toString("base64url");
  return `${tete}.${corps}.${sig}`;
}
function lireJwt(t) {
  const [tete, corps, sig] = String(t || "").split(".");
  if (!sig) return null;
  const pub = crypto.createPublicKey({ key: cles().jwk, format: "jwk" });
  if (!crypto.verify("sha256", Buffer.from(`${tete}.${corps}`), pub, Buffer.from(sig, "base64url"))) return null;
  const c = JSON.parse(Buffer.from(corps, "base64url").toString());
  return c.exp > maintenant() ? c : null;
}

/* ─── Mots de passe ─── */
async function empreinte(mdp, sel) {
  sel = sel || crypto.randomBytes(16).toString("base64");
  const h = await scrypt(String(mdp).normalize("NFC"), sel, 32, SCRYPT);
  return { sel, empreinte: h.toString("base64") };
}
// mots du bouton « Me proposer un mot de passe » (même liste dans site/comptes.html)
const MOTS_LATINS = "gloria pax lux verbum gratia spes fides caritas laudate veritas salve agnus rosa stella sancta magnificat jubilate alleluia benedic dominus psalmus hymnus vesper matutina credo sanctus ecce venite oremus amen caelum terra aqua ignis panis vinum oliva lilium cedrus palma columba leo aquila ovis pastor rex regina mater pater frater soror filius angelus sol luna nox dies aurora mane vespera hora tempus annus via vita porta domus templum altare crux corona sceptrum lucerna oleum sal mel lac fons flumen mare mons collis vallis hortus vinea messis semen granum spica arbor folium radix flos fructus cantus organum cithara psalterium tuba campana silentium pacem lumen splendor decor honor virtus sapientia scientia consilium fortitudo pietas timor laetitia gaudium amor misericordia iustitia humilitas oboedientia patientia benignitas";
// Mot de passe : libre (une seule lettre suffit, choix de l'utilisateur le 19/11/2026) ; seulement non vide et pas démesuré.
// La protection contre qui devine vient du blocage : 5 erreurs → 15 minutes.
const MDP_MAX = 200;
function refusMdp(mdp) {
  const m = String(mdp || "");
  if (!m) return "Indiquez un mot de passe.";
  if (m.length > MDP_MAX) return `Le mot de passe est trop long (${MDP_MAX} caractères au plus).`;
  return null;
}
const normId = (s) => String(s || "").trim().toLowerCase().normalize("NFC");
const idValide = (s) => /^[a-z0-9][a-z0-9._-]{1,39}$/.test(s);

/* ─── Stockage : table Azure « comptes » (SharedKeyLite, comme api/signalements) ─── */
const TABLE = "comptes", PK = "compte";
function compteStockage() {
  const cs = process.env.SIGNALEMENTS_STOCKAGE || "";
  const p = Object.fromEntries(cs.split(";").filter(Boolean).map((x) => { const i = x.indexOf("="); return [x.slice(0, i), x.slice(i + 1)]; }));
  if (!p.AccountName || !p.AccountKey) throw new Error("stockage non configuré");
  return { nom: p.AccountName, cle: Buffer.from(p.AccountKey, "base64"), suffixe: p.EndpointSuffix || "core.windows.net" };
}
async function appelTable(methode, chemin, corps, entetes = {}) {
  const c = compteStockage();
  const date = new Date().toUTCString();
  const signature = crypto.createHmac("sha256", c.cle).update(`${date}\n/${c.nom}/${chemin.split("?")[0]}`, "utf8").digest("base64");
  return fetch(`https://${c.nom}.table.${c.suffixe}/${chemin}`, {
    method: methode,
    headers: {
      "x-ms-date": date, "x-ms-version": "2019-02-02", Authorization: `SharedKeyLite ${c.nom}:${signature}`,
      Accept: "application/json;odata=nometadata", "Content-Type": "application/json", DataServiceVersion: "3.0;NetFx", ...entetes,
    },
    body: corps ? JSON.stringify(corps) : undefined,
  });
}
const nettoyer = (e) => { if (e) { delete e.Timestamp; delete e["odata.etag"]; } return e; };
const depotAzure = {
  async lire(id) {
    const r = await appelTable("GET", `${TABLE}(PartitionKey='${PK}',RowKey='${id}')`);
    if (r.status === 404) return null;
    if (!r.ok) throw new Error(`table GET ${r.status}`);
    return nettoyer(await r.json());
  },
  async ecrire(e) {
    const chemin = `${TABLE}(PartitionKey='${PK}',RowKey='${e.RowKey}')`;
    let r = await appelTable("PUT", chemin, { ...e, PartitionKey: PK });
    if (r.status === 404) {   // table pas encore créée
      await appelTable("POST", "Tables", { TableName: TABLE });
      r = await appelTable("PUT", chemin, { ...e, PartitionKey: PK });
    }
    if (!r.ok) throw new Error(`table PUT ${r.status} ${(await r.text()).slice(0, 200)}`);
  },
  async effacer(id) {
    const r = await appelTable("DELETE", `${TABLE}(PartitionKey='${PK}',RowKey='${id}')`, null, { "If-Match": "*" });
    if (!r.ok && r.status !== 404) throw new Error(`table DELETE ${r.status}`);
  },
  async lister() {
    const liste = [];
    let suite = "";
    for (let i = 0; i < 20; i++) {
      const r = await appelTable("GET", `${TABLE}()${suite}`);
      if (r.status === 404) break;
      if (!r.ok) throw new Error(`table GET ${r.status}`);
      liste.push(...((await r.json()).value || []).map(nettoyer));
      const pk = r.headers.get("x-ms-continuation-NextPartitionKey"), rk = r.headers.get("x-ms-continuation-NextRowKey");
      if (!pk) break;
      suite = `?NextPartitionKey=${encodeURIComponent(pk)}${rk ? `&NextRowKey=${encodeURIComponent(rk)}` : ""}`;
    }
    return liste;
  },
};
let depot = depotAzure;

/* ─── Réponses ─── */
const json = (status, body, plus = {}) => ({ status, headers: { "Content-Type": "application/json; charset=utf-8", "Cache-Control": "no-store", "X-Robots-Tag": "noindex, nofollow", ...plus }, body: JSON.stringify(body) });
const html = (status, body, plus = {}) => ({
  status, body,
  headers: {
    "Content-Type": "text/html; charset=utf-8", "Cache-Control": "no-store", "X-Frame-Options": "DENY", "X-Robots-Tag": "noindex, nofollow",
    "Content-Security-Policy": "default-src 'none'; style-src 'unsafe-inline'; img-src 'self'; script-src 'unsafe-inline'; form-action *; frame-ancestors 'none'",
    ...plus,
  },
});
const esc = (s) => String(s ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
const temoin = (valeur, age) => `${TEMOIN}=${valeur}; Path=/api/connexion; Max-Age=${age}; HttpOnly; Secure; SameSite=Lax`;
function lireTemoin(req) {
  const m = String((req.headers || {}).cookie || "").match(new RegExp(`(?:^|;\\s*)${TEMOIN}=([^;]+)`));
  return m ? m[1] : "";
}
function formulaire(req) {
  if (req.body && typeof req.body === "object" && !Buffer.isBuffer(req.body)) return req.body;
  const brut = typeof req.rawBody === "string" ? req.rawBody : typeof req.body === "string" ? req.body : Buffer.isBuffer(req.body) ? req.body.toString() : "";
  if (/json/.test((req.headers || {})["content-type"] || "")) { try { return JSON.parse(brut || "{}"); } catch (e) { return {}; } }
  return Object.fromEntries(new URLSearchParams(brut));
}

/* ─── Page de connexion (et d'inscription) ─── */
const PARAMS = ["client_id", "redirect_uri", "state", "nonce", "response_type", "response_mode", "scope", "code_challenge", "code_challenge_method"];
// o : { message, valeurs, inscription (formulaire d'inscription), inscriptionOuverte (lien « Créer mon compte ») }
function pageConnexion(p, o = {}) {
  const v = o.valeurs || {};
  const caches = PARAMS.filter((k) => p[k]).map((k) => `<input type="hidden" name="${k}" value="${esc(p[k])}">`).join("");
  const lien = (insc) => "authorize?" + new URLSearchParams([...PARAMS.filter((k) => p[k]).map((k) => [k, p[k]]), ...(insc ? [["inscription", "1"]] : [])]).toString();
  const champ = (id, libelle, type, autre = "") => `<label for="${id}">${libelle}</label>
<input type="${type}" id="${id}" name="${id}" value="${type === "password" ? "" : esc(v[id] || "")}" ${autre} required>`;
  const corps = o.inscription ? `<form method="post" action="authorize" autocomplete="on">${caches}<input type="hidden" name="action" value="inscrire">
${o.message ? `<p class="erreur" role="alert">${esc(o.message)}</p>` : ""}
${champ("nom", "Votre nom", "text", 'placeholder="Prénom Nom" autocomplete="name" maxlength="80" autofocus')}
${champ("identifiant", "Identifiant (pour vous connecter)", "text", 'placeholder="prenom.nom" autocapitalize="none" autocorrect="off" spellcheck="false" autocomplete="username" maxlength="40"')}
<p class="note">Lettres sans accent, chiffres, point ou tiret.</p>
${champ("mdp", "Mot de passe", "password", 'autocomplete="new-password" maxlength="200"')}
<p class="note"><button type="button" class="lien" id="proposer">Me proposer un mot de passe</button></p>
${champ("mdp2", "Mot de passe, encore une fois", "password", 'autocomplete="new-password" maxlength="200"')}
<p class="note" id="a-noter" hidden>Notez-le maintenant : il ne sera plus affiché.</p>
${o.avecCode ? `${champ("code", "Code d'inscription", "text", 'autocapitalize="none" autocorrect="off" spellcheck="false" autocomplete="off"')}
<p class="note">Donné par le frère qui gère le site.</p>` : ""}
<button>Créer mon compte</button>
</form>
<p class="aide"><a href="${esc(lien(false))}">J'ai déjà un compte : me connecter</a></p>
<script>
// identifiant proposé d’après le nom : « Marie Dupont » → marie.dupont
(function () {
  var nom = document.getElementById("nom"), id = document.getElementById("identifiant"), touche = !!id.value;
  id.addEventListener("input", function () { touche = true; });
  nom.addEventListener("input", function () {
    if (touche) return;
    // (barres obliques doublées : ce programme est écrit dans un gabarit du service)
    var b = nom.value.toLowerCase().replace(/œ/g, "oe").replace(/æ/g, "ae").normalize("NFD").replace(/[\\u0300-\\u036f]/g, "")
      .replace(/^\\s*(frere|fr\\.?|f\\.|soeur|sr\\.?|pere|p\\.)\\s+/, "").trim().replace(/\\s+/g, ".").replace(/[^a-z0-9.-]/g, "");
    id.value = b.slice(0, 40);
  });
  // quatre mots latins et un nombre : long donc solide, facile à dicter
  var MOTS = "${MOTS_LATINS}".split(" ");
  document.getElementById("proposer").addEventListener("click", function () {
    var n = new Uint32Array(5); crypto.getRandomValues(n);
    var m = [0, 1, 2, 3].map(function (i) { return MOTS[n[i] % MOTS.length]; }).join("-") + "-" + (10 + n[4] % 90);
    ["mdp", "mdp2"].forEach(function (k) { var c = document.getElementById(k); c.type = "text"; c.value = m; });
    document.getElementById("a-noter").hidden = false;
  });
})();
</script>` : `<form method="post" action="authorize" autocomplete="on">${caches}
${o.message ? `<p class="erreur" role="alert">${esc(o.message)}</p>` : ""}
<label for="identifiant">Identifiant</label>
<input type="text" id="identifiant" name="identifiant" value="${esc(v.identifiant || "")}" autocapitalize="none" autocorrect="off" spellcheck="false" autocomplete="username" required${v.identifiant ? "" : " autofocus"}>
<label for="mdp">Mot de passe</label>
<input type="password" id="mdp" name="mdp" autocomplete="current-password" required${v.identifiant ? " autofocus" : ""}>
<button>Entrer</button>
</form>
${o.inscriptionOuverte ? `<p class="aide premiere">Première visite ? <a href="${esc(lien(true))}">Créer mon compte</a></p>` : ""}
<p class="aide">Cet appareil restera connecté. Identifiant oublié : demandez-le au frère qui gère le site.</p>`;
  return `<!doctype html><html lang="fr"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="robots" content="noindex, nofollow"><meta name="theme-color" content="#7a1f1f">
<title>${o.inscription ? "Créer mon compte" : "Connexion"} — Bréviaire dominicain</title>
<link rel="icon" href="/icone.svg?v=2" type="image/svg+xml"><link rel="apple-touch-icon" href="/apple-touch-icon.png?v=2">
<style>
:root{--fond:#fbf8f2;--fond2:#f3eee4;--texte:#2b2520;--doux:#76695c;--rouge:#a3201c;--trait:#e2d9cb}
@media (prefers-color-scheme:dark){:root{--fond:#1a1714;--fond2:#24201c;--texte:#ece4d8;--doux:#a89c8e;--rouge:#e0716a;--trait:#3a332c}}
*{box-sizing:border-box}
body{margin:0;min-height:100vh;background:var(--fond);color:var(--texte);font:16px/1.45 -apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;
 display:flex;align-items:center;justify-content:center;padding:max(24px,env(safe-area-inset-top)) 16px 24px}
main{width:100%;max-width:360px}
.tete{text-align:center;margin-bottom:28px}
.tete img{width:64px;height:64px;border-radius:14px}
h1{font:500 28px/1.15 "Kepler Std Disp","Kepler Std",Georgia,"Times New Roman",serif;color:var(--rouge);margin:14px 0 4px}
.tete p{margin:0;color:var(--doux);font-size:14px;letter-spacing:.08em;text-transform:uppercase}
form{background:var(--fond2);border:1px solid var(--trait);border-radius:14px;padding:20px}
label{display:block;font-size:14px;color:var(--doux);margin:0 0 6px}
input[type=text],input[type=password]{display:block;width:100%;font:inherit;font-size:17px;padding:11px 12px;border:1px solid var(--trait);
 border-radius:10px;background:var(--fond);color:var(--texte);margin:0 0 16px}
input:focus{outline:2px solid var(--rouge);outline-offset:1px}
.note{color:var(--doux);font-size:13px;margin:-10px 0 16px}
button{width:100%;font:inherit;font-weight:600;font-size:17px;padding:12px;border:0;border-radius:10px;background:var(--rouge);color:#fff;cursor:pointer}
.erreur{color:var(--rouge);font-size:15px;margin:0 0 14px}
.aide{color:var(--doux);font-size:13px;text-align:center;margin:18px 0 0}
.aide.premiere{font-size:15px;color:var(--texte)}
button.lien{width:auto;background:none;color:var(--rouge);padding:0;font-size:14px;font-weight:500;text-decoration:underline;border-radius:0}
a{color:var(--rouge)}
</style></head><body><main>
<div class="tete"><img src="/icone.svg?v=2" alt=""><h1>Bréviaire dominicain</h1><p>${o.inscription ? "Créer mon compte" : "Connexion"}</p></div>
${corps}
</main></body></html>`;
}

/* ─── Paramètres d'une demande de connexion venue d'Azure ─── */
// Sites protégés par ce service (CONNEXION_SITES = adresses séparées par des virgules) ; à défaut, le site qui l'héberge.
// Le service est hébergé À PART du bréviaire (site « breviaire-connexion ») : logé dans le site qu'il protège,
// Azure tourne en rond (pour servir une page, il lit la description du service… dans ce même site) — constaté le 19/11/2026.
const sitesAutorises = (req) => (process.env.CONNEXION_SITES || new URL(emetteur(req)).origin).split(",").map((s) => s.trim().replace(/\/$/, "")).filter(Boolean);
function verifierDemande(p, req) {
  if (!egal(p.client_id || "", clientId())) return "client inconnu";
  if ((p.response_type || "code") !== "code") return "type de réponse non pris en charge";
  let r;
  try { r = new URL(p.redirect_uri || ""); } catch (e) { return "adresse de retour invalide"; }
  // retour seulement vers la porte d'Azure du même site : /.auth/login/<fournisseur>/callback
  if (!sitesAutorises(req).includes(r.origin) || !/^\/\.auth\/login\/[\w-]+\/callback$/.test(r.pathname)) return "adresse de retour refusée";
  return null;
}
function reponseCode(p, compte, plus = {}) {
  const code = signer({ t: "code", u: compte.RowKey, v: compte.version || 1, n: p.nonce || "", r: p.redirect_uri, cc: p.code_challenge || "", exp: maintenant() + DUREE_CODE });
  if ((p.response_mode || "query") === "form_post") {
    const champs = [["code", code], ...(p.state ? [["state", p.state]] : [])].map(([k, v]) => `<input type="hidden" name="${k}" value="${esc(v)}">`).join("");
    return html(200, `<!doctype html><html lang="fr"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Connexion…</title></head>
<body onload="document.forms[0].submit()"><form method="post" action="${esc(p.redirect_uri)}">${champs}<noscript><button>Continuer</button></noscript></form></body></html>`, plus);
  }
  const u = new URL(p.redirect_uri);
  u.searchParams.set("code", code);
  if (p.state) u.searchParams.set("state", p.state);
  return { status: 302, headers: { Location: u.href, "Cache-Control": "no-store", ...plus }, body: "" };
}
async function compteReconnu(req) {
  const t = lireSigne(lireTemoin(req));
  if (!t || t.t !== "appareil") return null;
  const c = await depot.lire(t.u);
  return c && c.actif !== false && (c.version || 1) === t.v ? c : null;
}
const nouveauTemoin = (c) => ({ "Set-Cookie": temoin(signer({ t: "appareil", u: c.RowKey, v: c.version || 1, exp: maintenant() + UN_AN }), UN_AN) });

async function authorize(req) {
  const m = (req.method || "GET").toUpperCase();
  const p = m === "POST" ? formulaire(req) : { ...(req.query || {}) };
  const refus = verifierDemande(p, req);
  if (refus) return html(400, `<!doctype html><meta charset="utf-8"><p>Demande de connexion invalide : ${esc(refus)}.</p></p>`);

  if (m !== "POST") {
    const c = await compteReconnu(req);          // appareil déjà connu : réponse immédiate, sans rien demander
    if (c) {
      await depot.ecrire({ ...c, derniere: new Date().toISOString() });
      return reponseCode(p, c, nouveauTemoin(c));
    }
    const { mode } = await reglageInscription();
    const ouverte = mode !== "fermee";
    return html(200, pageConnexion(p, { inscription: ouverte && p.inscription === "1", avecCode: mode === "code", inscriptionOuverte: ouverte }));
  }
  if (p.action === "inscrire") return inscrire(p);

  const id = normId(p.identifiant);
  const mdp = String(p.mdp || "");
  const echec = async (msg) => html(200, pageConnexion(p, { message: msg, valeurs: { identifiant: p.identifiant }, inscriptionOuverte: await inscriptionOuverte() }));
  const c = idValide(id) ? await depot.lire(id) : null;
  if (!c) { await empreinte(mdp || "x"); return echec("Identifiant ou mot de passe incorrect."); }   // même durée qu'un vrai essai
  const t = maintenant();
  if ((c.bloqueJusqua || 0) > t) return echec(`Trop d'essais : réessayez dans ${Math.ceil((c.bloqueJusqua - t) / 60)} minutes.`);
  const { empreinte: h } = await empreinte(mdp, c.sel);
  if (!egal(h, c.empreinte)) {
    const echecs = (c.echecs || 0) + 1;
    await depot.ecrire({ ...c, echecs: echecs >= ESSAIS_MAX ? 0 : echecs, bloqueJusqua: echecs >= ESSAIS_MAX ? t + BLOCAGE : 0 });
    return echec(echecs >= ESSAIS_MAX ? "Trop d'essais : réessayez dans 15 minutes." : "Identifiant ou mot de passe incorrect.");
  }
  if (c.actif === false) return echec("Ce compte est désactivé.");
  const maj = { ...c, echecs: 0, bloqueJusqua: 0, derniere: new Date().toISOString() };
  await depot.ecrire(maj);
  return reponseCode(p, maj, nouveauTemoin(maj));
}

/* ─── Inscription par le frère lui-même, avec le code d'inscription donné par l'administrateur ─── */
const REGLAGE_INSCRIPTION = "-inscription";      // ligne de réglage dans la table des comptes (jamais un identifiant valide)
const normCode = (s) => String(s || "").trim().toLowerCase().normalize("NFC");
// mode : "fermee" (par défaut) | "libre" (sans code) | "code" (code d'inscription demandé)
async function reglageInscription() {
  const r = await depot.lire(REGLAGE_INSCRIPTION);
  const mode = r && ["libre", "code"].includes(r.mode) ? r.mode : "fermee";
  return { mode: mode === "code" && !r.code ? "fermee" : mode, code: (r && r.code) || "" };
}
const inscriptionOuverte = async () => (await reglageInscription()).mode !== "fermee";
const pause = (ms) => new Promise((ok) => setTimeout(ok, ms));
async function inscrire(p) {
  const { mode, code } = await reglageInscription();
  const valeurs = { nom: p.nom, identifiant: p.identifiant, code: p.code };
  const echec = (msg) => html(200, pageConnexion(p, { inscription: true, avecCode: mode === "code", message: msg, valeurs }));
  if (mode === "fermee") return html(200, pageConnexion(p, { message: "Les inscriptions sont fermées. Demandez un compte au frère qui gère le site." }));
  if (mode === "code" && !egal(normCode(p.code), normCode(code))) { await pause(800); return echec("Code d'inscription incorrect."); }
  const nom = String(p.nom || "").trim().slice(0, 80);
  const id = normId(p.identifiant);
  if (!nom) return echec("Indiquez votre nom.");
  if (!idValide(id)) return echec("Identifiant : 2 à 40 caractères, lettres sans accent, chiffres, point ou tiret.");
  const refus = refusMdp(p.mdp, id);
  if (refus) return echec(refus);
  if (p.mdp !== p.mdp2) return echec("Les deux mots de passe ne sont pas les mêmes.");
  if (await depot.lire(id)) return echec("Cet identifiant est déjà pris : choisissez-en un autre.");
  const e = { RowKey: id, nom, actif: true, version: 1, origine: "inscription", cree: new Date().toISOString(), derniere: new Date().toISOString(), echecs: 0, bloqueJusqua: 0, ...(await empreinte(p.mdp)) };
  await depot.ecrire(e);
  return reponseCode(p, e, nouveauTemoin(e));
}

async function token(req) {
  const p = formulaire(req);
  let id = p.client_id, secret = p.client_secret;
  const basic = String((req.headers || {}).authorization || "").match(/^Basic\s+(.+)$/i);
  if (basic) { const d = Buffer.from(basic[1], "base64").toString(); const i = d.indexOf(":"); id = decodeURIComponent(d.slice(0, i)); secret = decodeURIComponent(d.slice(i + 1)); }
  if (!egal(id || "", clientId()) || !egal(secret || "", process.env.CONNEXION_CLIENT_SECRET || "")) return json(401, { error: "invalid_client" });
  if (p.grant_type !== "authorization_code") return json(400, { error: "unsupported_grant_type" });
  const code = lireSigne(p.code);
  if (!code || code.t !== "code" || code.r !== p.redirect_uri) return json(400, { error: "invalid_grant" });
  if (code.cc) {
    const v = crypto.createHash("sha256").update(String(p.code_verifier || "")).digest("base64url");
    if (!egal(v, code.cc)) return json(400, { error: "invalid_grant", error_description: "code_verifier" });
  }
  const c = await depot.lire(code.u);
  if (!c || c.actif === false || (c.version || 1) !== code.v) return json(400, { error: "invalid_grant" });
  const t = maintenant();
  const claims = { iss: emetteur(req), sub: c.RowKey, aud: clientId(), iat: t, exp: t + DUREE_ATTESTATION, name: c.nom || c.RowKey, preferred_username: c.RowKey, breviaire_roles: rolesDe(c).join(",") };
  if (code.n) claims.nonce = code.n;
  const idToken = jwt(claims);
  return json(200, { access_token: idToken, id_token: idToken, token_type: "Bearer", expires_in: DUREE_ATTESTATION, scope: "openid profile" });
}

function configuration(req) {
  const e = emetteur(req);
  return json(200, {
    issuer: e,
    authorization_endpoint: `${e}/authorize`, token_endpoint: `${e}/token`, userinfo_endpoint: `${e}/userinfo`,
    jwks_uri: `${e}/jwks`, end_session_endpoint: `${e}/deconnexion`,
    response_types_supported: ["code"], response_modes_supported: ["query", "form_post"],
    grant_types_supported: ["authorization_code"], subject_types_supported: ["public"],
    id_token_signing_alg_values_supported: ["RS256"], scopes_supported: ["openid", "profile"],
    token_endpoint_auth_methods_supported: ["client_secret_post", "client_secret_basic"],
    claims_supported: ["sub", "name", "preferred_username", "iss", "aud", "exp", "iat", "nonce", "breviaire_roles"],
    code_challenge_methods_supported: ["S256"],
  }, { "Cache-Control": "public, max-age=3600" });
}

/* ─── Gestion des comptes ─── */
/* ─── Rôles ─── « signalements » : voit les signalements reçus ; « comptes » : gère les comptes (et les inscriptions).
   Transmis à Azure dans l'attestation (claim « breviaire_roles ») ; le bréviaire les applique (api/roles). */
const ROLES = ["signalements", "comptes"];
const rolesDe = (c) => String((c && c.roles) || "").split(",").filter((r) => ROLES.includes(r));
// la personne connectée sur cet appareil (témoin du service), si elle a le rôle demandé
async function aLeRole(req, role) {
  const c = await compteReconnu(req);
  return !!c && rolesDe(c).includes(role);
}
function admin(req) {
  const attendu = process.env.CONNEXION_ADMIN_CLE || "";
  return attendu.length >= 12 && egal((req.headers || {})["x-cle"] || "", attendu);
}
const public_ = (c) => ({ id: c.RowKey, nom: c.nom || "", roles: rolesDe(c), inscrit: c.origine === "inscription", actif: c.actif !== false, cree: c.cree || "", derniere: c.derniere || "", bloque: (c.bloqueJusqua || 0) > maintenant() });
// accès à la gestion : la clé d'administration, ou une personne connectée sur cet appareil qui a le rôle « comptes »
// (témoin SameSite=Lax : jamais envoyé par un autre site pour une modification)
const gestion = async (req) => admin(req) || (await aLeRole(req, "comptes"));
async function comptes(req) {
  if (!(await gestion(req))) return json(401, { erreur: "clé d'administration manquante ou fausse" });
  const m = (req.method || "GET").toUpperCase();
  if (m === "GET") {
    const l = (await depot.lister()).filter((c) => !String(c.RowKey).startsWith("-")).map(public_).sort((a, b) => a.id.localeCompare(b.id));
    return json(200, l);
  }
  const p = formulaire(req);
  if (m === "POST") {
    const id = normId(p.id);
    if (!idValide(id)) return json(400, { erreur: "identifiant : 2 à 40 caractères, lettres sans accent, chiffres, point, tiret" });
    const refus = refusMdp(p.mdp, id);
    if (refus) return json(400, { erreur: refus });
    if (await depot.lire(id)) return json(409, { erreur: "cet identifiant existe déjà" });
    const e = { RowKey: id, nom: String(p.nom || "").trim().slice(0, 80), actif: true, version: 1, cree: new Date().toISOString(), derniere: "", echecs: 0, bloqueJusqua: 0, ...(await empreinte(p.mdp)) };
    await depot.ecrire(e);
    return json(201, public_(e));
  }
  const id = normId((req.query || {}).id);
  const c = idValide(id) ? await depot.lire(id) : null;
  if (!c) return json(404, { erreur: "compte inconnu" });
  if (m === "DELETE") { await depot.effacer(id); return json(200, { ok: true }); }
  if (m === "PUT") {
    const maj = { ...c };
    if (typeof p.nom === "string") maj.nom = p.nom.trim().slice(0, 80);
    if (p.mdp !== undefined) {
      const refus = refusMdp(p.mdp, id);
      if (refus) return json(400, { erreur: refus });
      Object.assign(maj, await empreinte(p.mdp), { version: (c.version || 1) + 1, echecs: 0, bloqueJusqua: 0 });
    }
    if (typeof p.actif === "boolean" && p.actif !== (c.actif !== false)) {
      maj.actif = p.actif;
      if (!p.actif) maj.version = (maj.version || 1) + 1;   // désactiver : tous ses appareils sont oubliés
    }
    if (p.debloquer) { maj.echecs = 0; maj.bloqueJusqua = 0; }
    if (Array.isArray(p.roles)) maj.roles = ROLES.filter((r) => p.roles.includes(r)).join(",");
    await depot.ecrire(maj);
    return json(200, public_(maj));
  }
  return json(405, { erreur: "méthode" });
}

/* ─── Aiguillage ─── */
async function traiter(req) {
  const chemin = String((req.params || {}).chemin || "").replace(/^\/+|\/+$/g, "");
  switch (chemin) {
    case ".well-known/openid-configuration": return configuration(req);
    case "jwks": return json(200, { keys: [cles().jwk] }, { "Cache-Control": "public, max-age=3600" });
    case "authorize": return authorize(req);
    case "token": return token(req);
    case "userinfo": {
      const b = String((req.headers || {}).authorization || "").match(/^Bearer\s+(.+)$/i);
      const c = b && lireJwt(b[1]);
      return c ? json(200, { sub: c.sub, name: c.name, preferred_username: c.preferred_username }) : json(401, { error: "invalid_token" });
    }
    case "deconnexion": {   // ?retour=<adresse du site> : oublie l'appareil, puis ferme la session Azure de ce site
      const sites = sitesAutorises(req), retour = String((req.query || {}).retour || "").replace(/\/$/, "");
      const site = sites.includes(retour) ? retour : sites[0];
      return { status: 302, headers: { Location: `${site}/.auth/logout?post_logout_redirect_uri=/`, "Set-Cookie": temoin("", 0), "Cache-Control": "no-store" }, body: "" };
    }
    case "comptes": return comptes(req);
    case "inscription": {   // réglage des inscriptions (gestion) : GET → { mode, code } ; PUT { mode, code }
      if (!(await gestion(req))) return json(401, { erreur: "clé d'administration manquante ou fausse" });
      if ((req.method || "GET").toUpperCase() === "PUT") {
        const f = formulaire(req);
        const mode = ["fermee", "libre", "code"].includes(f.mode) ? f.mode : "fermee";
        const code = String(f.code || "").trim().slice(0, 60);
        if (mode === "code" && code.length < 6) return json(400, { erreur: "code d'inscription : 6 caractères au moins" });
        await depot.ecrire({ RowKey: REGLAGE_INSCRIPTION, mode, code, modifie: new Date().toISOString() });
        return json(200, await reglageInscription());
      }
      return json(200, await reglageInscription());
    }
    default: return json(404, { erreur: "inconnu" });
  }
}

module.exports = async function (context, req) {
  try {
    context.res = await traiter(req);
  } catch (err) {
    (context.log && context.log.error ? context.log.error : console.error)(err);
    context.res = json(500, { erreur: "erreur du service de connexion" });
  }
};
module.exports.utiliserDepot = (d) => { depot = d; };   // essais (tests/connexion.test.js)
