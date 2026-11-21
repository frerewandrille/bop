#!/bin/bash
# Publie le bréviaire sur Azure : pages, scripts et textes dans la Static Web App « breviaire-dominicain »,
# images et données de la Bible dans l'entrepôt privé « breviairefichiers » (outils/entrepot.py).
# Le site est fermé par la connexion par compte (identifiant + mot de passe, docs/CONNEXION.md), assurée par
# le petit site à part « breviaire-connexion » (outils/publier_connexion.sh). Notice : docs/MISE-EN-LIGNE-AZURE.md.
# Avant : node outils/releve_images.mjs (liste des images utilisées) et bash tests/tout.sh.
#   bash outils/publier_azure.sh                    → le site avec les partitions, fermé par la connexion
#   bash outils/publier_azure.sh --sans-partitions  → le site seul
#   bash outils/publier_azure.sh --essai            → prépare tout sans rien envoyer (affiche la taille)
#   bash outils/publier_azure.sh --entrepot-seul    → met seulement l'entrepôt à jour (le site en ligne ne change pas)
#   bash outils/publier_azure.sh --garder-images    → laisse aussi les images dans le site (transition sans coupure)
#   Les images des partitions et les données de la Bible vont dans l'entrepôt Azure « breviairefichiers »
#   (outils/entrepot.py) ; seul le reste (pages, scripts, textes) va dans la Static Web App.
#   bash outils/publier_azure.sh --sans-bible       → sans la Bible (dossier bible/, publiée sinon sous /bible/)
#   Depuis le 19/11/2026, --connexion est implicite ; --sans-connexion le retire (le site s'ouvre alors à tous !).
#   bash outils/publier_azure.sh --connexion        → connexion par identifiant et mot de passe (docs/CONNEXION.md) :
#                                                     ajoute outils/connexion_azure.json à la configuration du site ;
#                                                     exige les réglages posés par outils/preparer_connexion.sh
#   bash outils/publier_azure.sh --forcer           → publie même si la liste des images utilisées est plus
#                                                     ancienne que le programme ou les index (déconseillé)
# Images publiées : seulement celles que le site affiche, d'après partitions/images-utilisees.json
# (fait par « node outils/releve_images.mjs », 20 à 40 minutes). Sans cette liste : toutes les pièces découpées.
# Le jeton de déploiement est lu dans Azure (connexion « az login » faite une fois sur ce Mac) ;
# à défaut, mettez-le dans la variable AZURE_SWA_TOKEN ou collez-le quand il est demandé.
# Réglages : nom du site et groupe de ressources (modifiables ici).
set -e
# connexion par compte implicite (19/11/2026) : un oubli ne doit pas rouvrir le site
if [[ " $* " != *" --sans-connexion "* ]] && [[ " $* " != *" --connexion "* ]]; then set -- "$@" --connexion; fi
NOM="${AZURE_SWA_NOM:-breviaire-dominicain}"
GROUPE="${AZURE_SWA_GROUPE:-breviaire}"
cd "$(dirname "$0")/.."

TOKEN="${AZURE_SWA_TOKEN:-}"
if [[ " $* " != *" --essai "* ]] && [ -z "$TOKEN" ] && command -v az >/dev/null; then
  TOKEN=$(az staticwebapp secrets list --name "$NOM" --resource-group "$GROUPE" --query properties.apiKey -o tsv 2>/dev/null || true)
fi
if [[ " $* " != *" --essai "* ]] && [ -z "$TOKEN" ]; then read -r -s -p "Jeton de déploiement Azure : " TOKEN; echo; fi

TMP=$(mktemp -d)
DIST="$TMP/site"
cp -R site "$DIST"
SANS_PARTITIONS=0; FORCER=0; ESSAI=0; GARDER=0; ENTREPOT_SEUL=0
for x in "$@"; do case "$x" in --sans-partitions) SANS_PARTITIONS=1 ;; --forcer) FORCER=1 ;; --essai) ESSAI=1 ;; --garder-images) GARDER=1 ;; --entrepot-seul) ENTREPOT_SEUL=1 ;; esac; done
LISTE=partitions/images-utilisees.json
if [ "$SANS_PARTITIONS" = 0 ] && [ -f "$LISTE" ]; then
  # la liste doit être plus récente que ce qui décide des images (programme, données, index des carnets)
  RECENTS=$(find site/js site/donnees partitions -maxdepth 2 \( -name '*.js' -o -name '*.json' \) -newer "$LISTE" ! -name 'images-utilisees.json' ! -name 'offices.json' | head -5)
  if [ -n "$RECENTS" ] && [ "$FORCER" = 0 ]; then
    echo "La liste des images utilisées est plus ancienne que :"; echo "$RECENTS" | sed 's/^/   /'
    echo "Relancez d'abord :  node outils/releve_images.mjs   (ou ajoutez --forcer)"; exit 1
  fi
fi
if [ "$SANS_PARTITIONS" = 0 ]; then
  mkdir -p "$DIST/partitions"
  # index et données des partitions (pas les images), corrections faites à la main
  rsync -a --exclude='ly/pieces.json' --include='*/' --include='*.json' --include='corrections/**' --exclude='images-utilisees.json' --exclude='*' partitions/ "$DIST/partitions/"
  if [ -f "$LISTE" ]; then
    echo "Copie des partitions affichées par le site (liste du $(python3 -c "import json;print(json.load(open('$LISTE'))['releve'][:10])"))…"
    python3 - "$DIST" "$LISTE" <<'PY2'
import json, os, shutil, sys
dist, liste = sys.argv[1], json.load(open(sys.argv[2]))
manque = 0
for f in liste["images"]:
    src = f"partitions/{f}"
    if not os.path.exists(src): manque += 1; continue
    os.makedirs(os.path.dirname(f"{dist}/{src}"), exist_ok=True); shutil.copy(src, f"{dist}/{src}")
print(f"  {len(liste['images']) - manque} images" + (f" ({manque} absentes du dossier)" if manque else ""))
PY2
  else
    echo "Pas de liste des images utilisées : copie de toutes les pièces découpées (plus lourd)."
    rsync -a --include='*/' --include='s-*.jpg' --include='a-*.jpg' --include='h-*.jpg' --include='sb/*.jpg' --exclude='*' partitions/ "$DIST/partitions/"
  # pages entières encore utilisées (pages du carnet sans pièce découpée)
    python3 - "$DIST" <<'PY'
import json, os, shutil, sys
dist = sys.argv[1]; I = json.load(open("partitions/index.json")); vus = {}
for e in I["pages"]:
    c = e["carnet"]; f = f"partitions/{c}/pieces.json"
    if c not in vus: vus[c] = {x["page"] for x in json.load(open(f))} if os.path.exists(f) else set()
    for p in [e["page"]] + e.get("suite", []):
        src = f"partitions/{c}/p-{p:03d}.jpg"
        if p not in vus[c] and os.path.exists(src): shutil.copy(src, f"{dist}/{src}")
# pages entières citées par l'ordo du sanctoral, et pages sans pièce découpée des carnets du temps (hymnes par pages)
import glob, re
if os.path.exists("partitions/ordo.json"):
    for f in set(re.findall(r'"([a-z0-9]+/p-\d+\.jpg)"', open("partitions/ordo.json").read())):
        if os.path.exists(f"partitions/{f}"): shutil.copy(f"partitions/{f}", f"{dist}/partitions/{f}")
for c in ("to", "avent", "careme", "paques"):
    f = f"partitions/{c}/pieces.json"
    if not os.path.exists(f): continue
    avec = {x["page"] for x in json.load(open(f))}
    for src in glob.glob(f"partitions/{c}/p-*.jpg"):
        if int(src[-7:-4]) not in avec: shutil.copy(src, f"{dist}/{src}")
PY
  fi
  # index allégés : les positions de découpe et le texte lu sous les portées ne servent qu'aux outils
  python3 - "$DIST" <<'PY3'
import glob, json, sys
for f in glob.glob(f"{sys.argv[1]}/partitions/*/pieces.json"):
    P = json.load(open(f))
    for x in P:
        for k in ("x0", "y0", "x1", "y1", "dedans", "ecart_dessus"): x.pop(k, None)
    json.dump(P, open(f, "w"), ensure_ascii=False, separators=(",", ":"))
PY3
  echo "Recompression des images pour le web…"
  find "$DIST/partitions" -name '*.jpg' -print0 | xargs -0 -n 200 sips -s formatOptions 45 >/dev/null 2>&1 || true
  du -sh "$DIST/partitions"
fi
# la Bible (dossier bible/, projet distinct) est publiée sous /bible/ du même site
if [[ " $* " != *" --sans-bible "* ]]; then bash bible/preparer_site.sh "$DIST/bible"; fi
# ── Entrepôt Azure : les images des partitions et les données de la Bible n'entrent pas dans le site (500 Mo au plus) ;
#    elles vont dans le compte de stockage « breviairefichiers » et les pages les y lisent (balise <meta name="fichiers">).
#    --garder-images : les laisse AUSSI dans le site (transition sans coupure pour un onglet resté ouvert).
# entrepôt PRIVÉ depuis le 18/11/2026 : lu par l'adresse « blob » avec une clé d'accès en lecture (outils/cle_entrepot.py),
# posée dans les pages (<meta name="fichiers-cle">), donc derrière le mot de passe du site
WEB="${AZURE_FICHIERS_WEB:-https://breviairefichiers.blob.core.windows.net/\$web/}"
# avec --connexion (19/11/2026) : AUCUNE clé dans les pages ; chaque appareil connecté reçoit une clé courte, renouvelée
# seule (api/fichiers, site/js/cle-fichiers.js). L'ancienne clé longue se coupe ensuite : python3 outils/cle_entrepot.py --revoquer
if [[ " $* " == *" --connexion "* ]]; then CLE_ENT=""
elif [ "$ESSAI" = 1 ]; then CLE_ENT=$(python3 outils/cle_entrepot.py --lire 2>/dev/null || echo essai); else CLE_ENT=$(python3 outils/cle_entrepot.py) || exit 1; fi
ENT="$TMP/entrepot"; mkdir -p "$ENT"
python3 - "$DIST" "$ENT" "$GARDER" <<'PY4'
import os, shutil, sys
dist, ent, garder = sys.argv[1], sys.argv[2], sys.argv[3] == "1"
n = 0
for racine, _, fichiers in os.walk(dist):
    for f in fichiers:
        p = os.path.join(racine, f); rel = os.path.relpath(p, dist)
        image = rel.startswith("partitions/") and f.lower().endswith((".jpg", ".jpeg", ".png"))
        bible = rel.startswith("bible/data/") and rel != "bible/data/books.js"
        if image or bible:
            os.makedirs(os.path.dirname(os.path.join(ent, rel)), exist_ok=True)
            (shutil.copy if (garder and image) or rel == "bible/data/books.js" else shutil.move)(p, os.path.join(ent, rel)); n += 1
print(f"  {n} fichiers pour l'entrepôt")
PY4
python3 - "$DIST" "$WEB" "$CLE_ENT" <<'PY5'
import html, os, sys
dist, web, cle = sys.argv[1:4]
for rel, base in (("index.html", web), ("messe.html", web), ("bible/index.html", web + "bible/"), ("bible/interlineaire.html", web + "bible/")):
    p = os.path.join(dist, rel)
    if not os.path.exists(p): continue
    t = open(p, encoding="utf-8").read()
    for nom, val in (("fichiers", base), ("fichiers-cle", cle)):
        vide = f'<meta name="{nom}" content="">'
        if vide not in t: sys.exit(f"{rel} : balise {nom} introuvable")
        t = t.replace(vide, f'<meta name="{nom}" content="{html.escape(val)}">')
    open(p, "w", encoding="utf-8").write(t)
PY5
[ $? = 0 ] || exit 1
printf 'User-agent: *\nDisallow: /\n' > "$ENT/robots.txt"
# ── Connexion par compte (--connexion) : chaque visiteur doit être connecté ; seules la page de connexion et les icônes restent ouvertes
if [[ " $* " == *" --connexion "* ]]; then
  # le service de connexion est logé à part, sur le site « breviaire-connexion » (outils/publier_connexion.sh)
  HOTE_SERVICE="${AZURE_CONNEXION_HOTE:-$(az staticwebapp show --name "${AZURE_CONNEXION_NOM:-breviaire-connexion}" --resource-group "$GROUPE" --query defaultHostname -o tsv 2>/dev/null || true)}"
  [ -n "$HOTE_SERVICE" ] || { echo "Service de connexion introuvable (site breviaire-connexion)."; exit 1; }
  if [ "$ESSAI" = 0 ]; then
    REGLES=$(az staticwebapp appsettings list --name "$NOM" --resource-group "$GROUPE" --environment-name "${AZURE_SWA_ENV:-default}" --query "properties" -o json 2>/dev/null || echo "{}")
    for r in CONNEXION_CLIENT_ID CONNEXION_CLIENT_SECRET ENTREPOT_STOCKAGE; do
      echo "$REGLES" | grep -q "\"$r\"" || { echo "Réglage $r absent du site : lancez d'abord  bash outils/preparer_connexion.sh"; exit 1; }
    done
  fi
  # liens vers le service (page Comptes, déconnexion) ; la page Comptes vit sur le service, pas ici
  sed -i '' "s|<meta name=\"connexion\" content=\"\">|<meta name=\"connexion\" content=\"https://$HOTE_SERVICE/\">|" "$DIST/index.html"
  grep -q "content=\"https://$HOTE_SERVICE/\"" "$DIST/index.html" || { echo "index.html : balise connexion introuvable"; exit 1; }
  rm -f "$DIST/comptes.html"
  python3 - "$DIST/staticwebapp.config.json" outils/connexion_azure.json "https://$HOTE_SERVICE/api/connexion" <<'PY6'
import json, sys
conf_f, frag_f, emetteur = sys.argv[1:4]
conf, frag = json.load(open(conf_f)), json.load(open(frag_f))
routes = [dict(r) for r in conf.get("routes", [])]
for r in routes: r.setdefault("allowedRoles", ["authenticated"])   # sinon la 1re route qui correspond ouvrirait ses fichiers à tous
conf["routes"] = frag["routesOuvertes"] + frag.get("routesRoles", []) + routes + [frag["routeFinale"]]
conf["responseOverrides"] = {**conf.get("responseOverrides", {}), **frag["responseOverrides"]}
conf["auth"] = json.loads(json.dumps(frag["auth"]).replace("__EMETTEUR__", emetteur))
json.dump(conf, open(conf_f, "w"), ensure_ascii=False, indent=2)
print(f"  connexion par compte : fournisseur {emetteur}")
PY6
fi
if [ "$ESSAI" = 1 ]; then python3 outils/entrepot.py "$ENT" --essai; else echo "Envoi vers l'entrepôt…"; python3 outils/entrepot.py "$ENT"; fi
if [ "$ENTREPOT_SEUL" = 1 ] && [ "$ESSAI" = 0 ]; then echo "Entrepôt à jour ; le site n'a pas été touché."; rm -rf "$TMP"; exit 0; fi
TAILLE=$(du -sm "$DIST" | cut -f1)
if [ "$TAILLE" -gt 490 ]; then echo "Trop gros pour Azure ($TAILLE Mo > 500 Mo) : arrêt."; exit 1; fi
du -sh "$DIST"
if [ "$ESSAI" = 1 ]; then echo "Essai : rien n'a été envoyé ($(find "$DIST/partitions" -name '*.jpg' 2>/dev/null | wc -l | tr -d ' ') images)."; rm -rf "$TMP"; exit 0; fi
echo "Envoi vers Azure…"
# lancé depuis le dossier temporaire : l'outil d'Azure y laisse son archive (.zip), effacée avec lui
# service de réception des signalements (dossier api/ : fonction Node, sans dépendance)
cp -R api "$TMP/api"
rm -rf "$TMP/api/connexion"     # le service de connexion est publié à part (outils/publier_connexion.sh)
(cd "$TMP" && npx --yes @azure/static-web-apps-cli deploy "$DIST" --api-location "$TMP/api" --api-language node --api-version 20 --env "${AZURE_SWA_DEPLOIEMENT:-production}" --deployment-token "$TOKEN")
rm -rf "$TMP"
echo "Terminé."
