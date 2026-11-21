#!/bin/bash
# Lance tous les contrôles du bréviaire, l'un après l'autre, et dit lesquels échouent.
#
#   bash tests/tout.sh              tous les contrôles (≈ 5 à 10 minutes)
#   bash tests/tout.sh calendrier   seulement ceux dont le nom contient « calendrier »
#
# Chaque contrôle est un petit programme Node (tests/*.test.js) qui lit les données de site/donnees/ et
# partitions/, fait tourner les programmes du site (site/js/) comme le ferait le navigateur, et s'arrête
# avec un code d'erreur si quelque chose ne va pas. Le compte rendu de chacun est gardé dans
# tests/derniers-resultats/ (non suivi par git) ; seule sa dernière ligne est affichée ici.
#
# À lancer après toute modification d'un programme de site/js/ ou d'un fichier de données.
cd "$(dirname "$0")/.."
mkdir -p tests/derniers-resultats
echecs=0
for t in tests/*.test.js; do
  n=$(basename "$t" .test.js)
  [ -n "$1" ] && [[ "$n" != *"$1"* ]] && continue
  debut=$(date +%s)
  node "$t" > "tests/derniers-resultats/$n.txt" 2>&1
  code=$?
  duree=$(( $(date +%s) - debut ))
  if [ $code -eq 0 ]; then etat="ok    "; else etat="ÉCHEC "; echecs=$((echecs + 1)); fi
  printf "%s %-16s %4ss  %s\n" "$etat" "$n" "$duree" "$(tail -1 "tests/derniers-resultats/$n.txt" | cut -c1-110)"
done
echo
if [ $echecs -eq 0 ]; then echo "Tous les contrôles passent."; else echo "$echecs contrôle(s) en échec : voir tests/derniers-resultats/"; fi
exit $echecs
