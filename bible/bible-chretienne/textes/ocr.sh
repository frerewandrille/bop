#!/bin/bash
# OCR du volume « Bible chrétienne II — Les quatre Évangiles » (scan Internet Archive, 348 planches doubles).
# Chaque planche est rendue en gris à 380 dpi, coupée en deux (1 = page gauche, 2 = page droite),
# puis lue par tesseract (français) : travail/ocr/pPPP-K.txt (texte) et .tsv (mots + positions).
#   bash bible/bible-chretienne/textes/ocr.sh ["chemin/du/livre.pdf"]
PDF="${1:-$HOME/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MNDocs/Bible chrétienne.pdf}"
ICI="$(cd "$(dirname "$0")" && pwd)"; OUT="$ICI/travail/ocr"; mkdir -p "$OUT"
N=$(pdfinfo "$PDF" | awk '/^Pages:/{print $2}')
un() { p=$1; PDF="$2"; OUT="$3"; f=p$(printf %03d $p)
  [ -s "$OUT/$f-2.tsv" ] && return
  T=$(mktemp -d)
  pdftoppm -f $p -l $p -r 380 -gray -x 0    -y 0 -W 2222 -H 3150 "$PDF" "$T/a"
  pdftoppm -f $p -l $p -r 380 -gray -x 2222 -y 0 -W 2222 -H 3150 "$PDF" "$T/b"
  OMP_THREAD_LIMIT=1 tesseract "$T"/a-*.pgm "$OUT/$f-1" -l fra --psm 3 txt tsv >/dev/null 2>&1
  OMP_THREAD_LIMIT=1 tesseract "$T"/b-*.pgm "$OUT/$f-2" -l fra --psm 3 txt tsv >/dev/null 2>&1
  rm -rf "$T"; }
export -f un
seq 1 $N | xargs -P 10 -I{} bash -c 'un {} "$0" "$1"' "$PDF" "$OUT"
# Table générale (planches 335-339) relue à 500 dpi, en lignes : bien plus fiable pour les colonnes Mt/Mc/Lc/Jn
T="$ICI/travail/table"; mkdir -p "$T"
for p in 335 336 337 338 339; do
  [ -s "$T/b$p-$p.tsv" ] && continue
  pdftoppm -f $p -l $p -r 500 -gray -x 0    -y 0 -W 2923 -H 4145 "$PDF" "$T/a$p"
  pdftoppm -f $p -l $p -r 500 -gray -x 2923 -y 0 -W 2923 -H 4145 "$PDF" "$T/b$p"
  for f in "$T"/[ab]$p-*.pgm; do tesseract "$f" "${f%.pgm}" -l fra --psm 6 txt tsv >/dev/null 2>&1; rm "$f"; done
done
echo "OCR : $(find "$OUT" -name '*.tsv' | wc -l) pages"
