#!/bin/bash
# Refait site/polices/kepler-*.woff2 depuis les Kepler Std (.otf) installées dans ~/Library/Fonts.
# Besoin : fonttools + brotli (pip install fonttools brotli). Sous-ensemble : latin, ponctuation, ligatures.
set -e
cd "$(dirname "$0")/.."
for f in Regular Italic Medium MediumIt SemiboldIt Bold BoldIt MediumCapt ItCapt SemiboldCapt BoldCapt \
         Subh ItSubh MediumSubh SemiboldSubh Disp ItDisp MediumDisp SemiboldDisp; do
  pyftsubset "$HOME/Library/Fonts/KeplerStd-$f.otf" \
    --unicodes="U+0000-024F,U+0300-036F,U+1E00-1EFF,U+2000-206F,U+20AC,U+2100-214F,U+2190-2193,U+2212,U+2715,U+271D,U+2720,U+FB00-FB06" \
    --layout-features='kern,liga,ccmp,mark,mkmk,onum,lnum,pnum,tnum,smcp,c2sc,frac,sups' \
    --flavor=woff2 --output-file="site/polices/kepler-$f.woff2"
done
