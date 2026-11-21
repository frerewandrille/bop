\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key f \major \time 3/4 }

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
  { \armure \cadenzaOn \tonRVIdf }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Si quelqu’un a soif, ' qu’il vienne à moi" et qu’il boive,
    "de mon sein coule" -- "ront des fleu" -- ves d’eau vive_!
    "Jésus disait ce" -- là de l’Es -- prit
    "que devaient recevoir ceux qui croi" -- raient en lui.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    
  }
  \addlyrics
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Si tu savais le" don de Dieu
    "et quel est ce" -- "lui qui te de" -- mande à boire,
    "c’est toi qui lui au" -- rais de -- man -- dé,
    "et il t’aurait donné" de l’eau vive.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Vous tous qui avez soif, ' ve" -- nez vers l’eau.
    "Voici. ' Je répands des" "flots sur le sol" as -- soif -- fé.
    "Sur tes en" -- "fants, ' je répands" mon Es -- prit.
    "Que l’homme de désir boive l’eau" de la vie_!
  }
  \addlyrics
  { 
    \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
    
  }
  \addlyrics
  { 
    \set stanza = #"6." \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = #" Dox 7." \set shortVocalName = \markup\right-align"7." 
    "Louange au Dieu unique et" trois fois saint_!
    "En vérité, je vous le" "dis : ' L’heure vient, et" nous y sommes,
    "Où les vrais adora" -- "teurs ' adore" -- ront le Père
    "Dans l’Esprit et la" Vé -- ri -- té.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIdh }
>>