#!/bin/bash
# Prépare la connexion par identifiant et mot de passe (docs/CONNEXION.md) :
#   1. fabrique, une seule fois, les secrets (clé de signature, secret du site, clé d'administration),
#      gardés sur ce Mac dans .secrets_connexion/ (jamais dans git) ;
#   2. les pose dans les réglages Azure :
#      - site « breviaire-connexion » (le service de connexion, logé à part) : tous les réglages du service ;
#      - site « breviaire-dominicain » (environnement AZURE_SWA_ENV, « default » = le site lui-même) :
#        identité auprès du service (CONNEXION_CLIENT_ID / _SECRET, lus par Azure) et clé de l'entrepôt.
#
#   bash outils/preparer_connexion.sh                    → le bréviaire lui-même
#   AZURE_SWA_ENV=essai bash outils/preparer_connexion.sh → un environnement d'essai du bréviaire (déjà publié)
#   bash outils/preparer_connexion.sh --local            → secrets seulement, rien n'est envoyé
#
# La clé d'administration (page « Comptes ») est écrite dans .cle_comptes.txt.
# Relancer ce script ne change pas les secrets existants (les appareils connectés le restent).
set -e
cd "$(dirname "$0")/.."
NOM="${AZURE_SWA_NOM:-breviaire-dominicain}"
SERVICE="${AZURE_CONNEXION_NOM:-breviaire-connexion}"
GROUPE="${AZURE_SWA_GROUPE:-breviaire}"
ENV="${AZURE_SWA_ENV:-default}"
S=.secrets_connexion
mkdir -p "$S"; chmod 700 "$S"

[ -f "$S/cle_privee.pem" ] || { openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out "$S/cle_privee.pem" 2>/dev/null; echo "Clé de signature fabriquée."; }
[ -f "$S/client_secret" ] || openssl rand -base64 33 | tr -d '\n/+=' > "$S/client_secret"
[ -f .cle_comptes.txt ] || { openssl rand -base64 18 | tr -d '\n/+=' > .cle_comptes.txt; echo "Clé d'administration fabriquée : .cle_comptes.txt"; }
chmod 600 "$S"/* .cle_comptes.txt

if [[ " $* " == *" --local "* ]]; then echo "Secrets prêts (rien n'a été envoyé)."; exit 0; fi
command -v az >/dev/null || { echo "Outil « az » introuvable (az login nécessaire)."; exit 1; }

HOTE_SERVICE=$(az staticwebapp show --name "$SERVICE" --resource-group "$GROUPE" --query defaultHostname -o tsv)
[ -n "$HOTE_SERVICE" ] || { echo "Site $SERVICE introuvable."; exit 1; }
HOTE_SITE=$(az staticwebapp environment list --name "$NOM" --resource-group "$GROUPE" --query "[?name=='default'].hostname | [0]" -o tsv)
HOTE_ENV=$(az staticwebapp environment list --name "$NOM" --resource-group "$GROUPE" --query "[?name=='$ENV'].hostname | [0]" -o tsv)
[ -n "$HOTE_ENV" ] || { echo "Environnement $ENV de $NOM introuvable."; exit 1; }
SITES="https://$HOTE_SITE"
[ "$HOTE_ENV" = "$HOTE_SITE" ] || SITES="$SITES,https://$HOTE_ENV"
STOCKAGE=$(az staticwebapp appsettings list --name "$NOM" --resource-group "$GROUPE" --query "properties.SIGNALEMENTS_STOCKAGE" -o tsv)

# 1. le service de connexion
az staticwebapp appsettings set --name "$SERVICE" --resource-group "$GROUPE" --setting-names \
  "CONNEXION_CLIENT_ID=breviaire" \
  "CONNEXION_CLIENT_SECRET=$(cat "$S/client_secret")" \
  "CONNEXION_CLE_PRIVEE=$(base64 < "$S/cle_privee.pem" | tr -d '\n')" \
  "CONNEXION_ADMIN_CLE=$(cat .cle_comptes.txt)" \
  "CONNEXION_EMETTEUR=https://$HOTE_SERVICE/api/connexion" \
  "CONNEXION_SITES=$SITES" \
  "SIGNALEMENTS_STOCKAGE=$STOCKAGE" >/dev/null
echo "Service de connexion : https://$HOTE_SERVICE (sites autorisés : $SITES)."

# 2. le bréviaire (ou son environnement d'essai)
az staticwebapp appsettings set --name "$NOM" --resource-group "$GROUPE" --environment-name "$ENV" --setting-names \
  "CONNEXION_CLIENT_ID=breviaire" \
  "CONNEXION_CLIENT_SECRET=$(cat "$S/client_secret")" \
  "ENTREPOT_STOCKAGE=$(az storage account show-connection-string -n breviairefichiers -g "$GROUPE" -o tsv)" >/dev/null
echo "Bréviaire, environnement $ENV : https://$HOTE_ENV."
