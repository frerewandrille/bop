#!/bin/bash
# OCR du scan « Bible chrétienne » (planches doubles) : une page PDF -> deux fichiers texte (gauche g, droite d).
#   bash bible-chretienne/ocr.sh "chemin/du/livre.pdf"
P="$1"; D="$(cd "$(dirname "$0")" && pwd)"; mkdir -p "$D/ocr"
N=$(pdfinfo "$P" | awk '/^Pages:/{print $2}')
un() { p=$1; P="$2"; D="$3"; f=$(printf %03d $p); T=$(mktemp -d)
  [ -s "$D/ocr/$f-d.txt" ] && { rm -r "$T"; return; }
  pdftoppm -f $p -l $p -r 300 -gray -x 0    -y 0 -W 1700 -H 2481 "$P" "$T/g"
  pdftoppm -f $p -l $p -r 300 -gray -x 1700 -y 0 -W 1808 -H 2481 "$P" "$T/d"
  tesseract "$T"/g-*.pgm "$D/ocr/$f-g" -l fra 2>/dev/null
  tesseract "$T"/d-*.pgm "$D/ocr/$f-d" -l fra 2>/dev/null
  rm -r "$T"; }
export -f un
seq 1 $N | xargs -P 10 -I{} bash -c 'un {} "$0" "$1"' "$P" "$D"
echo "OCR terminé : $(ls "$D/ocr" | wc -l) fichiers"
