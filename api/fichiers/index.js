/* Clé de lecture de l'entrepôt (partitions, données de la Bible), délivrée aux seules personnes connectées.

   GET /api/fichiers/cle.js → petit programme qui pose window.CLE_FICHIERS et le garde sur l'appareil
   (chargé par site/js/cle-fichiers.js). Azure ne laisse entrer ici que les personnes connectées (règle « /* »),
   et ce service le vérifie encore (en-tête x-ms-client-principal posé par Azure).

   La clé est une « signature d'accès partagé » en lecture seule sur le conteneur $web, signée avec la clé du compte
   de stockage (réglage ENTREPOT_STOCKAGE = sa chaîne de connexion). Elle vaut 30 à 45 jours ; tous les appareils
   reçoivent la même pendant 15 jours (adresses identiques : le cache des navigateurs reste valable), puis la suivante.
   Rien à faire à la main : les appareils la renouvellent seuls. Une personne désactivée ne reçoit plus de clé ;
   celle qu'elle avait cesse de marcher au plus tard 45 jours après. */
const crypto = require("crypto");

const JOUR = 86400, PERIODE = 15 * JOUR, VERSION = "2021-08-06", CONTENEUR = "$web";

function compte() {
  const cs = process.env.ENTREPOT_STOCKAGE || "";
  const p = Object.fromEntries(cs.split(";").filter(Boolean).map((x) => { const i = x.indexOf("="); return [x.slice(0, i), x.slice(i + 1)]; }));
  if (!p.AccountName || !p.AccountKey) throw new Error("ENTREPOT_STOCKAGE manquant");
  return { nom: p.AccountName, cle: Buffer.from(p.AccountKey, "base64") };
}
const iso = (s) => new Date(s * 1000).toISOString().replace(/\.\d{3}Z$/, "Z");

// signature d'accès partagé « service », conteneur entier, lecture seule (format des versions ≥ 2020-12-06)
function cleDeLecture(maintenant = Math.floor(Date.now() / 1000)) {
  const c = compte();
  const debutPeriode = Math.floor(maintenant / PERIODE) * PERIODE;
  const st = iso(debutPeriode - 3600), se = iso(debutPeriode + 3 * PERIODE);
  const champs = ["r", st, se, `/blob/${c.nom}/${CONTENEUR}`, "", "", "https", VERSION, "c", "", "", "", "", "", "", ""];
  const sig = crypto.createHmac("sha256", c.cle).update(champs.join("\n"), "utf8").digest("base64");
  const q = new URLSearchParams({ sv: VERSION, spr: "https", st, se, sr: "c", sp: "r", sig });
  return { cle: q.toString(), fin: debutPeriode + 3 * PERIODE };
}

function connecte(req) {
  const h = (req.headers || {})["x-ms-client-principal"];
  if (!h) return false;
  try { return (JSON.parse(Buffer.from(h, "base64").toString()).userRoles || []).includes("authenticated"); } catch (e) { return false; }
}

module.exports = async function (context, req) {
  const js = (status, corps) => ({ status, headers: { "Content-Type": "text/javascript; charset=utf-8", "Cache-Control": "no-store, private" }, body: corps });
  try {
    if (!connecte(req)) { context.res = js(401, "/* non connecté */"); return; }
    const k = cleDeLecture();
    context.res = js(200, `window.CLE_FICHIERS=${JSON.stringify(k.cle)};try{localStorage.setItem("breviaire-cle-fichiers",${JSON.stringify(JSON.stringify(k))})}catch(e){}`);
  } catch (err) {
    (context.log && context.log.error ? context.log.error : console.error)(err);
    context.res = js(500, "/* clé indisponible */");
  }
};
module.exports.cleDeLecture = cleDeLecture;   // essais
