/* Réception des signalements d'erreurs (Azure Static Web Apps, fonction gérée).

   POST /api/signalements            → enregistre un signalement (ouvert à tous : c'est le bouton « Envoyer » du site)
   GET  /api/signalements            → liste (en-tête « x-cle » = clé de lecture obligatoire)
   PUT  /api/signalements?id=…&traite=1|0 → marque traité / à traiter (clé obligatoire)

   Stockage : une table Azure (« signalements »), appelée directement par son interface web (aucune dépendance).
   Réglages de l'application (portail Azure ou az staticwebapp appsettings) :
     SIGNALEMENTS_STOCKAGE = chaîne de connexion du compte de stockage
     SIGNALEMENTS_CLE      = clé de lecture (page « Signalements ») */
const crypto = require("crypto");

const TABLE = "signalements";
const CHAMPS = ["date", "office", "version", "titre", "adresse", "cle", "section", "piece", "provenance", "classes",
  "passage", "commentaire", "site", "appareil", "cree"];

function compte() {
  const cs = process.env.SIGNALEMENTS_STOCKAGE || "";
  const p = Object.fromEntries(cs.split(";").filter(Boolean).map((x) => { const i = x.indexOf("="); return [x.slice(0, i), x.slice(i + 1)]; }));
  if (!p.AccountName || !p.AccountKey) throw new Error("stockage non configuré");
  return { nom: p.AccountName, cle: Buffer.from(p.AccountKey, "base64"), suffixe: p.EndpointSuffix || "core.windows.net" };
}

// Appel de l'interface des tables, signé « SharedKeyLite »
async function table(methode, chemin, corps, entetes = {}) {
  const c = compte();
  const date = new Date().toUTCString();
  const ressource = `/${c.nom}/${chemin.split("?")[0]}`;
  const signature = crypto.createHmac("sha256", c.cle).update(`${date}\n${ressource}`, "utf8").digest("base64");
  const r = await fetch(`https://${c.nom}.table.${c.suffixe}/${chemin}`, {
    method: methode,
    headers: {
      "x-ms-date": date, "x-ms-version": "2019-02-02", Authorization: `SharedKeyLite ${c.nom}:${signature}`,
      Accept: "application/json;odata=nometadata", "Content-Type": "application/json", DataServiceVersion: "3.0;NetFx",
      ...entetes,
    },
    body: corps ? JSON.stringify(corps) : undefined,
  });
  if (!r.ok && r.status !== 404) throw new Error(`table ${methode} ${r.status} ${(await r.text()).slice(0, 200)}`);
  return r;
}

const texte = (v, n) => String(v ?? "").slice(0, n);
const json = (status, body) => ({ status, headers: { "Content-Type": "application/json", "Cache-Control": "no-store" }, body: JSON.stringify(body) });
// rôle « signalements » donné par la connexion par compte (Azure le transmet dans x-ms-client-principal) : pas de clé à taper
const aLeRole = (req) => {
  try {
    const p = JSON.parse(Buffer.from(String(req.headers["x-ms-client-principal"] || ""), "base64").toString() || "{}");
    return (p.userRoles || []).includes("signalements");
  } catch (e) { return false; }
};
const autorise = (req) => {
  if (aLeRole(req)) return true;
  const attendu = process.env.SIGNALEMENTS_CLE || "";
  const donne = String(req.headers["x-cle"] || "");
  return attendu.length >= 12 && donne.length === attendu.length && crypto.timingSafeEqual(Buffer.from(donne), Buffer.from(attendu));
};
const versEntite = (s) => {
  const e = { PartitionKey: texte(s.cree || new Date().toISOString(), 7), RowKey: texte(s.id, 60).replace(/[^\w-]/g, "") };
  for (const k of CHAMPS) e[k] = texte(s[k], k === "passage" || k === "commentaire" ? 4000 : 400);
  e.partitions = JSON.stringify(Array.isArray(s.partitions) ? s.partitions.slice(0, 20).map((x) => texte(x, 200)) : []);
  e.reglages = JSON.stringify(s.reglages && typeof s.reglages === "object" ? s.reglages : {}).slice(0, 2000);
  e.recu = new Date().toISOString();
  e.traite = false;
  return e;
};
const depuisEntite = (e) => {
  const s = { id: e.RowKey, mois: e.PartitionKey, recu: e.recu, traite: !!e.traite };
  for (const k of CHAMPS) s[k] = e[k] || "";
  try { s.partitions = JSON.parse(e.partitions || "[]"); } catch (x) { s.partitions = []; }
  try { s.reglages = JSON.parse(e.reglages || "{}"); } catch (x) { s.reglages = {}; }
  return s;
};

module.exports = async function (context, req) {
  try {
    const m = (req.method || "").toUpperCase();
    if (m === "POST") {
      const s = req.body && typeof req.body === "object" ? req.body : JSON.parse(req.rawBody || "{}");
      if (!s || !s.id || JSON.stringify(s).length > 64000) { context.res = json(400, { erreur: "signalement invalide" }); return; }
      const e = versEntite(s);
      if (!e.RowKey) { context.res = json(400, { erreur: "identifiant invalide" }); return; }
      // insérer ou remplacer : un renvoi du même signalement (réserve hors connexion) ne fait pas de doublon
      await table("PUT", `${TABLE}(PartitionKey='${e.PartitionKey}',RowKey='${e.RowKey}')`, e);
      context.res = json(201, { ok: true });
      return;
    }
    if (!autorise(req)) { context.res = json(401, { erreur: "clé de lecture manquante ou fausse" }); return; }
    if (m === "GET") {
      const liste = [];
      let suite = "";
      for (let i = 0; i < 50; i++) {
        const r = await table("GET", `${TABLE}()${suite}`);
        if (r.status === 404) break;
        const d = await r.json();
        liste.push(...(d.value || []).map(depuisEntite));
        const pk = r.headers.get("x-ms-continuation-NextPartitionKey"), rk = r.headers.get("x-ms-continuation-NextRowKey");
        if (!pk) break;
        suite = `?NextPartitionKey=${encodeURIComponent(pk)}${rk ? `&NextRowKey=${encodeURIComponent(rk)}` : ""}`;
      }
      liste.sort((a, b) => String(b.cree).localeCompare(String(a.cree)));
      context.res = json(200, liste);
      return;
    }
    if (m === "PUT") {
      const id = String(req.query.id || "").replace(/[^\w-]/g, ""), mois = String(req.query.mois || "").replace(/[^\d-]/g, "");
      if (!id || !mois) { context.res = json(400, { erreur: "id et mois requis" }); return; }
      const chemin = `${TABLE}(PartitionKey='${mois}',RowKey='${id}')`;
      const r = await table("GET", chemin);
      if (r.status === 404) { context.res = json(404, { erreur: "inconnu" }); return; }
      const e = await r.json();
      delete e.Timestamp; delete e["odata.etag"];
      e.traite = req.query.traite !== "0";
      await table("PUT", chemin, e);
      context.res = json(200, { ok: true, traite: e.traite });
      return;
    }
    context.res = json(405, { erreur: "méthode" });
  } catch (err) {
    context.log.error(err);
    context.res = json(500, { erreur: "erreur du service" });
  }
};
