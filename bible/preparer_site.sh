#!/bin/bash
# Copie les fichiers publiables de la Bible dans le dossier donné (appelé par ../outils/publier_azure.sh,
# qui la place sous /bible/ du site du bréviaire). Seules les pages, styles, polices, icônes et données
# partent ; les programmes Python restent ici.
#   bash bible/preparer_site.sh DOSSIER
set -e
DEST="$1"; [ -n "$DEST" ] || { echo "usage : preparer_site.sh DOSSIER"; exit 1; }
cd "$(dirname "$0")"
[ -f data/books.js ] || { echo "Bible : données absentes, lancez  python3 bible/extract.py"; exit 1; }
python3 horsligne.py > /dev/null   # liste des paquets de la lecture hors connexion (data/horsligne.js)
mkdir -p "$DEST"
cp index.html interlineaire.html lectio.css lectio.js app.js style.css liens.js polices.css recherche.js recherche.css lectio.webmanifest icone-180.png icone-512.png sw.js "$DEST/"
cp -R polices data "$DEST/"
printf 'Bible : %s\n' "$(du -sh "$DEST" | cut -f1)"
