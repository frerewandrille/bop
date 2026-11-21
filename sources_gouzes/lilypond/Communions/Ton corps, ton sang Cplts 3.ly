\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIIcf }
  
  \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    "Grand Prêtre de l’alliance nou" -- velle,
    "tu as offert le sacri" -- "fice sur l’autel" de la croix.
    "Tu te livres en donnant le pain" et le vin,
    "tu nourris l’Église par ton Corps" et ton Sang.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIch }
>>