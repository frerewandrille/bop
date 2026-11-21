/* Clé de lecture de l'entrepôt (partitions, données de la Bible) : demandée au site après la connexion
   (/api/fichiers/cle.js), gardée sur l'appareil, renouvelée seule en arrière-plan. Rien à faire à la main.
   Chargé avant les scripts qui lisent l'entrepôt (partitions.js, bible/app.js, bible/lectio.js), qui lisent
   window.CLE_FICHIERS. Sans adresse d'entrepôt (<meta name="fichiers"> vide : en local), ne fait rien.
   Hors connexion : la dernière clé gardée ; les fichiers enregistrés se retrouvent sans elle. */
(function () {
  "use strict";
  var meta = document.querySelector('meta[name="fichiers"]');
  if (!meta || !meta.content) return;
  var NOM = "breviaire-cle-fichiers", JOUR = 86400, k = null;
  try { k = JSON.parse(localStorage.getItem(NOM) || "null"); } catch (e) { /* rien */ }
  var reste = k && k.fin ? k.fin - Date.now() / 1000 : -1;
  if (k && k.cle) window.CLE_FICHIERS = k.cle;          // même périmée : utile hors connexion
  if (reste > 3 * JOUR) {
    // encore bonne : on s'en sert tout de suite, et on prend la suivante quand elle existe (tous les 15 jours)
    if (reste < 32 * JOUR) {
      fetch("/api/fichiers/cle.js", { cache: "no-store", credentials: "same-origin" })
        .then(function (r) { return r.ok ? r.text() : ""; })
        .then(function (t) { var m = t.match(/setItem\("breviaire-cle-fichiers",("(?:[^"\\]|\\.)*")\)/); if (m) localStorage.setItem(NOM, JSON.parse(m[1])); })
        .catch(function () { /* hors connexion : plus tard */ });
    }
    return;
  }
  // pas de clé, ou presque périmée : on l'attend avant la suite de la page (une fois tous les quelques mois)
  document.write('<script src="/api/fichiers/cle.js?' + Date.now() + '"><\/script>');
})();
