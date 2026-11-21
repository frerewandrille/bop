\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 18) indent = 0

armure = { \key bes \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose bes g
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIIqf }

  \addlyrics
  { 
    \set stanza = " (Le 26) 1." \set shortVocalName = \markup\right-align"1." 
    "À la brise du soir, ' dans le jardin du" Pa -- ra -- dis,
    "tu venais visiter Adam, ton" bien_- ai -- mé.
    "Au soir du monde, ' tu viens" sur la terre
    "et tu nous établis" dans la Paix
  }
  \addlyrics
  { 
    \set stanza = "(Le 27) 2." \set shortVocalName = \markup\right-align"2." 
    "Tu es venu dans le buis" -- son ar -- dent,
     "flamme de feu au cœur" du dé -- sert.
     "Tu es descendu dans le sein" de Ma -- rie,
     "Lumière pour tous les peuples" de la terre.
  }
  \addlyrics
  { 
    \set stanza = "(Le 28) 3." \set shortVocalName = \markup\right-align"3." 
    "Les cieux avec la terre se fondent" en un chant,
    "les anges et les bergers ' chantent ta gloire en" un seul chœur_;
    "Marie par son silence ' et les mages par" leur pré -- sents
    "te reconnaissent comme" leur Sau -- veur.
  }
  \addlyrics
  { 
    \set stanza = "(Le 29) 4." \set shortVocalName = \markup\right-align"4." 
    "La Mère de Dieu a accueilli le salut" en son sein.
    "Elle se réjouit en ce jour ' avec les anges et" les ber -- gers.
    "Que tous les hommes aient part" à sa joie_:
    "Par elle est détruite l’antique ma" -- lé -- dic -- tion.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = "(Le 30) 5." \set shortVocalName = \markup\right-align"5." 
    "Et nous pécheurs, ' lavés par" ton A -- mour,
    "unis avec les saints de" tous les temps,
    "nous attendons ta venue" dans la gloire
    "et nous t’acclamons ' notre Sauveur et" no -- tre Roi.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = " (Dox.) 6." \set shortVocalName = \markup\right-align"6." 
    "Gloire au Père qui a envoyé son Verbe" sur la terre.
    "Gloire au Verbe fait chair ' qui a habité" par -- mi nous.
    "Gloire à l’Esprit ' qui a reposé sur la Vier" -- ge très sainte.
    "Trinité Sainte," gloire à toi_!
  }


  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIqh }
>>