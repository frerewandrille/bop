#!/bin/bash
# Double-cliquer après avoir modifié le psautier, la Bible (.doc) ou un document Gouzes
# (dossier « sources_gouzes ») : régénère les données du site.
cd "$(dirname "$0")"
python3 outils/construire_donnees.py && python3 outils/construire_calendrier.py && python3 outils/construire_gouzes.py
echo; read -n 1 -s -r -p "Terminé. Appuyez sur une touche pour fermer."
