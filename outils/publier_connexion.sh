#!/bin/bash
# Publie le service de connexion (docs/CONNEXION.md) sur son propre petit site Azure, « breviaire-connexion »
# (offre gratuite). Il ne peut pas être logé dans le bréviaire lui-même : Azure y tourne en rond (19/11/2026).
#   bash outils/publier_connexion.sh
# Contenu publié : api/connexion (le service), comptes.html (page Comptes, clé d'administration), l'icône,
# une page d'accueil qui renvoie au bréviaire. Aucun texte du bréviaire.
set -e
cd "$(dirname "$0")/.."
NOM="${AZURE_CONNEXION_NOM:-breviaire-connexion}"
GROUPE="${AZURE_SWA_GROUPE:-breviaire}"
SITE_HOTE=$(az staticwebapp show --name breviaire-dominicain --resource-group "$GROUPE" --query defaultHostname -o tsv)
TOKEN=$(az staticwebapp secrets list --name "$NOM" --resource-group "$GROUPE" --query properties.apiKey -o tsv)
[ -n "$TOKEN" ] || { echo "Site $NOM introuvable."; exit 1; }

TMP=$(mktemp -d)
mkdir -p "$TMP/site/css" "$TMP/api"
cp -R api/connexion "$TMP/api/connexion"
cp api/host.json api/package.json "$TMP/api/"
cp site/icone.svg site/apple-touch-icon.png "$TMP/site/"
cp site/css/office.css "$TMP/site/css/"
# page Comptes : sans les polices du bréviaire (licence d'usage limitée au bréviaire), retour vers le bréviaire
sed -e '/css\/polices.css/d' -e "s|<a href=\"./\">‹ Retour au bréviaire</a>|<a href=\"https://$SITE_HOTE/\">‹ Retour au bréviaire</a>|" site/comptes.html > "$TMP/site/comptes.html"
cat > "$TMP/site/index.html" <<EOF
<!doctype html><html lang="fr"><head><meta charset="utf-8"><meta name="robots" content="noindex, nofollow">
<meta http-equiv="refresh" content="0; url=https://$SITE_HOTE/"><title>Bréviaire dominicain</title></head>
<body><p><a href="https://$SITE_HOTE/">Bréviaire dominicain</a></p></body></html>
EOF
cat > "$TMP/site/staticwebapp.config.json" <<'EOF'
{
  "globalHeaders": { "X-Content-Type-Options": "nosniff", "Referrer-Policy": "same-origin", "X-Robots-Tag": "noindex, nofollow", "X-Frame-Options": "DENY" },
  "routes": [ { "route": "/comptes.html", "headers": { "Cache-Control": "no-cache" } } ]
}
EOF
printf 'User-agent: *\nDisallow: /\n' > "$TMP/site/robots.txt"
echo "Envoi du service de connexion vers $NOM…"
(cd "$TMP" && npx --yes @azure/static-web-apps-cli deploy ./site --api-location ./api --api-language node --api-version 20 --env production --deployment-token "$TOKEN")
rm -rf "$TMP"
