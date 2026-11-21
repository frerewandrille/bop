#!/bin/bash
# Convertit les carnets de chœur (PDF) en images de pages : partitions/<code>/p001.jpg …
# Usage : bash outils/rendre_partitions.sh "<dossier des carnets>"
D="$1"; cd "$(dirname "$0")/.."
declare -a L=("to|Temps ordinaire-MàJ juillet 2018.pdf" "avent|Livret-Avent-2019.pdf" "noel|livret du temps de Noël.pdf" "careme|Livret de Careme 3.0 ODENDALL DBJL.pdf" "paques|Livret Temps Pascal-final.pdf" "sanctoral1|Sanctoral-sept-jan.pdf" "milieu|Office du milieu du jour (carnet Province).pdf")
for x in "${L[@]}"; do
  code="${x%%|*}"; f="${x#*|}"
  mkdir -p "partitions/$code"
  [ -f "partitions/$code/.fini" ] && continue
  pdftoppm -r 110 -gray -jpeg -jpegopt quality=72 "$D/$f" "partitions/$code/p" || continue
  # numéros sur trois chiffres (p-001.jpg), quelle que soit la longueur du carnet
  for g in "partitions/$code"/p-*.jpg; do n=${g##*/p-}; n=${n%.jpg}; m=$(printf %03d $((10#$n))); [ "$n" = "$m" ] || mv "$g" "partitions/$code/p-$m.jpg"; done
  touch "partitions/$code/.fini"
  echo "$code fini"
done
