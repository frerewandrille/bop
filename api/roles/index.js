/* Rôles des personnes connectées (« rolesSource » d'Azure Static Web Apps, voir outils/connexion_azure.json).
   Azure appelle ce service à chaque connexion avec les informations de l'attestation du service de connexion ;
   le rôle y est écrit par lui (claim « breviaire_roles » : « signalements », « comptes », séparés par des virgules).
   Azure applique ensuite les règles d'accès (signalements.html, lecture des signalements) selon ces rôles.
   Une personne qui appellerait ce service elle-même n'obtient rien : Azure seul se sert de la réponse. */
const ROLES = ["signalements", "comptes"];

module.exports = async function (context, req) {
  const corps = req.body && typeof req.body === "object" ? req.body : (() => { try { return JSON.parse(req.rawBody || "{}"); } catch (e) { return {}; } })();
  const roles = new Set();
  for (const c of Array.isArray(corps.claims) ? corps.claims : []) {
    const typ = String(c.typ || "");
    if (typ === "breviaire_roles" || typ.endsWith("/breviaire_roles"))
      String(c.val || "").split(/[,\s]+/).filter((r) => ROLES.includes(r)).forEach((r) => roles.add(r));
  }
  context.res = { status: 200, headers: { "Content-Type": "application/json", "Cache-Control": "no-store" }, body: JSON.stringify({ roles: [...roles] }) };
};
