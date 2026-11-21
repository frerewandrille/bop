/* Essai complet du service de connexion (api/connexion), sans Azure : node tests/connexion.test.js
   Joue le rôle d'Azure Static Web Apps (fournisseur OpenID Connect) et celui du navigateur. */
const assert = require("assert");
const crypto = require("crypto");

const { privateKey } = crypto.generateKeyPairSync("rsa", { modulusLength: 2048 });
process.env.CONNEXION_CLE_PRIVEE = Buffer.from(privateKey.export({ type: "pkcs8", format: "pem" })).toString("base64");
process.env.CONNEXION_CLIENT_ID = "breviaire";
process.env.CONNEXION_CLIENT_SECRET = "secret-du-site-essai";
process.env.CONNEXION_ADMIN_CLE = "cle-administration-essai";
delete process.env.CONNEXION_EMETTEUR;

const service = require("../api/connexion/index.js");
const table = new Map();
service.utiliserDepot({
  async lire(id) { return table.has(id) ? { ...table.get(id) } : null; },
  async ecrire(e) { table.set(e.RowKey, { ...e }); },
  async effacer(id) { table.delete(id); },
  async lister() { return [...table.values()]; },
});

const SITE = "https://bréviaire.essai".replace("é", "e");
const HOTE = new URL(SITE).host;
async function appel(chemin, { methode = "GET", query = {}, corps, entetes = {} } = {}) {
  const ctx = { log: { error: (e) => console.error(e) } };
  const req = { method: methode, params: { chemin }, query, headers: { host: HOTE, "x-forwarded-proto": "https", ...entetes } };
  if (corps !== undefined) {
    if (typeof corps === "string") { req.rawBody = corps; req.body = corps; req.headers["content-type"] = "application/x-www-form-urlencoded"; }
    else { req.body = corps; req.rawBody = JSON.stringify(corps); req.headers["content-type"] = "application/json"; }
  }
  await service(ctx, req);
  return ctx.res;
}
const form = (o) => new URLSearchParams(o).toString();
const temoinDe = (r) => { const s = (r.headers || {})["Set-Cookie"] || ""; return s.split(";")[0]; };
const champ = (html, nom) => { const m = html.match(new RegExp(`name="${nom}" value="([^"]*)"`)); return m && m[1].replace(/&amp;/g, "&").replace(/&quot;/g, '"'); };
const admin = { "x-cle": "cle-administration-essai" };

let n = 0;
const ok = (msg) => { n++; console.log("  ✓ " + msg); };

(async () => {
  // 1. Description du fournisseur
  const conf = JSON.parse((await appel(".well-known/openid-configuration")).body);
  assert.strictEqual(conf.issuer, `${SITE}/api/connexion`);
  assert.strictEqual(conf.authorization_endpoint, `${SITE}/api/connexion/authorize`);
  ok("description du fournisseur");

  // 2. Gestion des comptes
  assert.strictEqual((await appel("comptes")).status, 401);
  assert.strictEqual((await appel("comptes", { entetes: { "x-cle": "mauvaise-cle-12345" } })).status, 401);
  let r = await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "Fr.Pierre", nom: "Frère Pierre", mdp: "Laudate Dominum" } });
  assert.strictEqual(r.status, 201, r.body);
  assert.strictEqual(JSON.parse(r.body).id, "fr.pierre");
  assert.ok(!JSON.stringify([...table.values()]).includes("Laudate"), "mot de passe stocké en clair !");
  assert.strictEqual((await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "fr.pierre", mdp: "autre-mdp" } })).status, 409);
  assert.strictEqual((await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "fr paul", mdp: "123456" } })).status, 400);
  assert.strictEqual((await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "fr.paul", mdp: "" } })).status, 400, "mot de passe vide refusé");
  assert.strictEqual((await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "fr.paul", mdp: "x".repeat(201) } })).status, 400, "démesuré refusé");
  assert.strictEqual((await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "fr.paul", mdp: "a" } })).status, 201, "une seule lettre acceptée");
  await appel("comptes", { methode: "DELETE", query: { id: "fr.paul" }, entetes: admin });
  const liste = JSON.parse((await appel("comptes", { entetes: admin })).body);
  assert.deepStrictEqual(liste.map((c) => c.id), ["fr.pierre"]);
  assert.ok(!("empreinte" in liste[0]) && !("sel" in liste[0]));
  ok("création de compte, refus des doublons et des formats invalides, empreinte seulement");

  // 3. Azure envoie le visiteur à la page de connexion
  const verifier = crypto.randomBytes(32).toString("base64url");
  const demande = {
    client_id: "breviaire", redirect_uri: `${SITE}/.auth/login/breviaire/callback`, response_type: "code", response_mode: "form_post",
    scope: "openid profile", state: "etat-123", nonce: "nonce-456",
    code_challenge: crypto.createHash("sha256").update(verifier).digest("base64url"), code_challenge_method: "S256",
  };
  r = await appel("authorize", { query: demande });
  assert.strictEqual(r.status, 200);
  assert.ok(r.body.includes('name="identifiant"') && r.body.includes('name="mdp"'));
  ok("page de connexion affichée");

  for (const [k, v] of [["redirect_uri", "https://pirate.example/.auth/login/breviaire/callback"], ["redirect_uri", `${SITE}/ailleurs`], ["client_id", "autre"]]) {
    assert.strictEqual((await appel("authorize", { query: { ...demande, [k]: v } })).status, 400);
  }
  ok("demandes venues d'ailleurs refusées");

  // 4. Mauvais mot de passe, puis le bon
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "fr.pierre", mdp: "faux" }) });
  assert.ok(r.body.includes("incorrect") && !temoinDe(r));
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "inconnu", mdp: "faux" }) });
  assert.ok(r.body.includes("incorrect"));
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: " FR.Pierre ", mdp: "Laudate Dominum" }) });
  assert.strictEqual(r.status, 200);
  assert.ok(r.body.includes(`action="${demande.redirect_uri}"`), "retour vers Azure (form_post)");
  const code = champ(r.body, "code");
  assert.strictEqual(champ(r.body, "state"), "etat-123");
  const appareil = temoinDe(r);
  assert.ok(appareil.startsWith("breviaire-compte="));
  assert.ok(/Max-Age=31536000; HttpOnly; Secure/.test(r.headers["Set-Cookie"]));
  ok("bon mot de passe : code rendu à Azure, appareil mémorisé un an");

  // 5. Azure échange le code
  const echange = { grant_type: "authorization_code", code, redirect_uri: demande.redirect_uri, code_verifier: verifier };
  assert.strictEqual((await appel("token", { methode: "POST", corps: form({ ...echange, client_id: "breviaire", client_secret: "faux" }) })).status, 401);
  assert.strictEqual((await appel("token", { methode: "POST", corps: form({ ...echange, client_id: "breviaire", client_secret: "secret-du-site-essai", code_verifier: "x" }) })).status, 400);
  const basic = "Basic " + Buffer.from("breviaire:secret-du-site-essai").toString("base64");
  r = await appel("token", { methode: "POST", corps: form(echange), entetes: { authorization: basic } });
  assert.strictEqual(r.status, 200, r.body);
  const jeton = JSON.parse(r.body);
  const [t64, c64, s64] = jeton.id_token.split(".");
  const jwks = JSON.parse((await appel("jwks")).body);
  const cle = jwks.keys.find((k) => k.kid === JSON.parse(Buffer.from(t64, "base64url")).kid);
  assert.ok(crypto.verify("sha256", Buffer.from(`${t64}.${c64}`), crypto.createPublicKey({ key: cle, format: "jwk" }), Buffer.from(s64, "base64url")), "signature");
  const claims = JSON.parse(Buffer.from(c64, "base64url"));
  assert.strictEqual(claims.iss, conf.issuer);
  assert.strictEqual(claims.aud, "breviaire");
  assert.strictEqual(claims.sub, "fr.pierre");
  assert.strictEqual(claims.name, "Frère Pierre");
  assert.strictEqual(claims.nonce, "nonce-456");
  const ui = JSON.parse((await appel("userinfo", { entetes: { authorization: "Bearer " + jeton.access_token } })).body);
  assert.strictEqual(ui.sub, "fr.pierre");
  ok("attestation signée, vérifiable par la clé publique (émetteur, destinataire, nonce, nom)");

  // 6. Session Azure expirée : l'appareil est reconnu sans rien demander
  r = await appel("authorize", { query: { ...demande, state: "etat-2", nonce: "n2" }, entetes: { cookie: `autre=1; ${appareil}` } });
  assert.ok(r.body.includes('name="code"') && !r.body.includes('name="mdp"'), "pas de page de connexion");
  assert.ok(temoinDe(r), "témoin renouvelé");
  r = await appel("authorize", { query: { ...demande, response_mode: "query" }, entetes: { cookie: appareil } });
  assert.strictEqual(r.status, 302);
  assert.ok(r.headers.Location.startsWith(demande.redirect_uri + "?code="));
  ok("appareil reconnu : reconnexion silencieuse (form_post et query)");

  // 7. Désactivation : l'appareil est oublié
  r = await appel("comptes", { methode: "PUT", query: { id: "fr.pierre" }, entetes: admin, corps: { actif: false } });
  assert.strictEqual(JSON.parse(r.body).actif, false);
  r = await appel("authorize", { query: demande, entetes: { cookie: appareil } });
  assert.ok(r.body.includes('name="mdp"'), "page de connexion à nouveau");
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "fr.pierre", mdp: "Laudate Dominum" }) });
  assert.ok(r.body.includes("désactivé"));
  ok("compte désactivé : appareils oubliés, connexion refusée");

  // 8. Réactivation, changement de mot de passe
  await appel("comptes", { methode: "PUT", query: { id: "fr.pierre" }, entetes: admin, corps: { actif: true, mdp: "Magnificat 2027" } });
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "fr.pierre", mdp: "Laudate Dominum" }) });
  assert.ok(r.body.includes("incorrect"));
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "fr.pierre", mdp: "Magnificat 2027" }) });
  assert.ok(champ(r.body, "code"));
  ok("réactivation et nouveau mot de passe");

  // 9. Blocage après 5 erreurs
  for (let i = 0; i < 5; i++) r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "fr.pierre", mdp: "faux" + i }) });
  assert.ok(r.body.includes("Trop d&#39;essais"));
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "fr.pierre", mdp: "Magnificat 2027" }) });
  assert.ok(r.body.includes("Trop d&#39;essais"), "bloqué même avec le bon mot de passe");
  assert.strictEqual(JSON.parse((await appel("comptes", { entetes: admin })).body)[0].bloque, true);
  await appel("comptes", { methode: "PUT", query: { id: "fr.pierre" }, entetes: admin, corps: { debloquer: true } });
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: "fr.pierre", mdp: "Magnificat 2027" }) });
  assert.ok(champ(r.body, "code"));
  ok("5 erreurs : compte bloqué 15 minutes ; déblocage par la page Comptes");

  // 10. Code rejoué après expiration, code falsifié
  const faux = code.slice(0, -2) + (code.endsWith("A") ? "BB" : "AA");
  assert.strictEqual((await appel("token", { methode: "POST", corps: form({ ...echange, code: faux }), entetes: { authorization: basic } })).status, 400);
  ok("code falsifié refusé");

  // 11. Déconnexion
  r = await appel("deconnexion");
  assert.strictEqual(r.status, 302);
  assert.ok(/Max-Age=0/.test(r.headers["Set-Cookie"]) && r.headers.Location.startsWith(SITE + "/.auth/logout"));
  ok("déconnexion : appareil oublié puis session Azure fermée");

  // 12. Suppression
  await appel("comptes", { methode: "DELETE", query: { id: "fr.pierre" }, entetes: admin });
  assert.strictEqual(table.size, 0);
  ok("suppression d'un compte");

  // 13. Échappement dans la page (identifiant malveillant)
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, identifiant: '"><script>alert(1)</script>', mdp: "x" }) });
  assert.ok(!r.body.includes("<script>alert"));
  ok("page de connexion protégée contre l'injection de code");

  // 14. Inscription par le frère lui-même : fermée par défaut
  r = await appel("authorize", { query: demande });
  assert.ok(!r.body.includes("Créer mon compte"), "pas de lien tant que les inscriptions sont fermées");
  r = await appel("authorize", { methode: "POST", corps: form({ ...demande, action: "inscrire", nom: "Intrus", identifiant: "intrus", mdp: "123456", mdp2: "123456" }) });
  assert.ok(r.body.includes("fermées") && !table.has("intrus"));
  assert.strictEqual((await appel("inscription", { methode: "PUT", corps: { mode: "libre" } })).status, 401);
  ok("inscriptions fermées par défaut");

  // 15. Inscriptions libres : sans code
  assert.strictEqual(JSON.parse((await appel("inscription", { methode: "PUT", entetes: admin, corps: { mode: "libre" } })).body).mode, "libre");
  r = await appel("authorize", { query: demande });
  assert.ok(r.body.includes("Créer mon compte"));
  r = await appel("authorize", { query: { ...demande, inscription: "1" } });
  assert.ok(r.body.includes('name="mdp2"') && !r.body.includes('name="code"'), "formulaire sans code");
  const insc = { ...demande, action: "inscrire", nom: "Marie Dupont", identifiant: "marie.dupont", mdp: "ave-maria", mdp2: "ave-maria" };
  r = await appel("authorize", { methode: "POST", corps: form({ ...insc, mdp2: "autre-chose" }) });
  assert.ok(r.body.includes("ne sont pas les mêmes") && r.body.includes('value="Marie Dupont"'));
  r = await appel("authorize", { methode: "POST", corps: form(insc) });
  assert.ok(champ(r.body, "code") && temoinDe(r), "inscrit et connecté aussitôt");
  r = await appel("authorize", { methode: "POST", corps: form(insc) });
  assert.ok(r.body.includes("déjà pris"));
  const l2 = JSON.parse((await appel("comptes", { entetes: admin })).body);
  assert.deepStrictEqual(l2.map((c) => [c.id, c.inscrit]), [["marie.dupont", true]], "la ligne de réglage n'est pas un compte");
  ok("inscriptions libres : le frère crée son compte et entre aussitôt");

  // 16. Inscriptions avec code
  assert.strictEqual((await appel("inscription", { methode: "PUT", entetes: admin, corps: { mode: "code", code: "abc" } })).status, 400);
  await appel("inscription", { methode: "PUT", entetes: admin, corps: { mode: "code", code: "Gloria-Pax-33" } });
  r = await appel("authorize", { query: { ...demande, inscription: "1" } });
  assert.ok(r.body.includes('name="code"'));
  const insc2 = { ...insc, nom: "Paul", identifiant: "paul" };
  r = await appel("authorize", { methode: "POST", corps: form({ ...insc2, code: "mauvais" }) });
  assert.ok(r.body.includes("Code d&#39;inscription incorrect") && !table.has("paul"));
  r = await appel("authorize", { methode: "POST", corps: form({ ...insc2, code: " gloria-pax-33 " }) });
  assert.ok(champ(r.body, "code") && table.has("paul"), "code accepté sans tenir compte des majuscules");
  await appel("inscription", { methode: "PUT", entetes: admin, corps: { mode: "fermee" } });
  assert.ok(!(await appel("authorize", { query: demande })).body.includes("Créer mon compte"));
  ok("inscriptions avec code d'inscription, puis refermées");

  // 17. Service hébergé à part : seuls les sites de CONNEXION_SITES peuvent demander une connexion
  process.env.CONNEXION_SITES = "https://breviaire.exemple, https://autre.exemple/";
  r = await appel("authorize", { query: { ...demande, redirect_uri: "https://breviaire.exemple/.auth/login/breviaire/callback" } });
  assert.strictEqual(r.status, 200);
  assert.strictEqual((await appel("authorize", { query: demande })).status, 400, "le site hôte n'est plus autorisé");
  assert.strictEqual((await appel("authorize", { query: { ...demande, redirect_uri: "https://pirate.exemple/.auth/login/breviaire/callback" } })).status, 400);
  r = await appel("deconnexion", { query: { retour: "https://autre.exemple" } });
  assert.ok(r.headers.Location.startsWith("https://autre.exemple/.auth/logout"));
  r = await appel("deconnexion", { query: { retour: "https://pirate.exemple" } });
  assert.ok(r.headers.Location.startsWith("https://breviaire.exemple/.auth/logout"), "pas de renvoi vers un site inconnu");
  delete process.env.CONNEXION_SITES;
  ok("service à part : sites autorisés seulement, déconnexion vers le bon site");

  // 18. Rôles : « signalements » et « comptes »
  await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "wandrille", nom: "Wandrille", mdp: "x" } });
  await appel("comptes", { methode: "POST", entetes: admin, corps: { id: "simple", nom: "Simple", mdp: "y" } });
  r = await appel("comptes", { methode: "PUT", query: { id: "wandrille" }, entetes: admin, corps: { roles: ["signalements", "comptes", "pirate"] } });
  assert.deepStrictEqual(JSON.parse(r.body).roles, ["signalements", "comptes"], "rôle inconnu ignoré");
  const connecter = async (id, mdp) => {
    const rr = await appel("authorize", { methode: "POST", corps: form({ ...demande, response_mode: "form_post", code_challenge: "", identifiant: id, mdp }) });
    return { code: champ(rr.body, "code"), temoin: temoinDe(rr) };
  };
  const w = await connecter("wandrille", "x"), s = await connecter("simple", "y");
  const claimsDe = async (code) => {
    const rr = await appel("token", { methode: "POST", corps: form({ grant_type: "authorization_code", code, redirect_uri: demande.redirect_uri }), entetes: { authorization: basic } });
    return JSON.parse(Buffer.from(JSON.parse(rr.body).id_token.split(".")[1], "base64url"));
  };
  assert.strictEqual((await claimsDe(w.code)).breviaire_roles, "signalements,comptes");
  assert.strictEqual((await claimsDe(s.code)).breviaire_roles, "");
  // gestion des comptes sans clé, par le témoin de l'appareil d'une personne qui a le rôle « comptes »
  assert.strictEqual((await appel("comptes", { entetes: { cookie: w.temoin } })).status, 200);
  assert.strictEqual((await appel("comptes", { entetes: { cookie: s.temoin } })).status, 401);
  assert.strictEqual((await appel("inscription", { methode: "PUT", entetes: { cookie: s.temoin }, corps: { mode: "libre" } })).status, 401);
  await appel("comptes", { methode: "PUT", query: { id: "wandrille" }, entetes: admin, corps: { roles: ["signalements"] } });
  assert.strictEqual((await appel("comptes", { entetes: { cookie: w.temoin } })).status, 401, "rôle retiré : effet immédiat ici");
  ok("rôles : transmis à Azure, gestion des comptes sans clé pour qui a le rôle");

  // 19. Côté bréviaire : api/roles (rolesSource) et lecture des signalements par le rôle
  const roles = require("../api/roles/index.js");
  const ctxR = {};
  await roles(ctxR, { body: { claims: [{ typ: "name", val: "W" }, { typ: "breviaire_roles", val: "signalements,comptes,admin" }] } });
  assert.deepStrictEqual(JSON.parse(ctxR.res.body).roles, ["signalements", "comptes"]);
  const ctxR2 = {};
  await roles(ctxR2, { body: { claims: [{ typ: "breviaire_roles", val: "" }] } });
  assert.deepStrictEqual(JSON.parse(ctxR2.res.body).roles, []);
  const sig = require("../api/signalements/index.js");
  const principal = (rs) => Buffer.from(JSON.stringify({ userRoles: ["anonymous", "authenticated", ...rs] })).toString("base64");
  const ctxS = {};
  await sig(ctxS, { method: "GET", query: {}, headers: { "x-ms-client-principal": principal([]) } });
  assert.strictEqual(ctxS.res.status, 401, "sans rôle : pas de liste");
  ok("bréviaire : rôles lus dans l'attestation ; signalements refusés sans rôle");

  console.log(`connexion : ${n} essais réussis`);
})().catch((e) => { console.error(e); process.exit(1); });
