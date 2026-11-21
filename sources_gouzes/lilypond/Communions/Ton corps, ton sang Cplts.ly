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
  
%   \addlyrics
%   { 
%     \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
%     "Par ta mort, ô Christ, ' tu as vaincu la" mort
%     "et tu nous rassa" -- "sies de ta mi" -- sé -- ri -- corde_:
%     "Pour nous, tu as brisé les portes" des En -- fers_;
%     "tu nous ouvres le ciel par ta ré" -- sur -- rec -- tion.
%   }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    
  }
  \addlyrics
  %\with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Fêtons la Pâque de l’Agneau véri" -- table_!
    "Ô Christ, tu as livré ta" "chair au supplice" de la Croix_!
    "Ô Fils unique, tu t’es humilié jus" -- \apostrophe qu’à la mort,
    "mais le Père t’a exalté et" fait Sei -- gneur.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Fêtons la Pâque qui nous ouvre la Terre pro" -- mise
    "et qui nous fait passer de l’escla" -- "vage à la" li -- ber -- té_!
    "Jésus, nouveau Moïse, tu guides le peuple des" bap -- ti -- sés
    "au festin du Royaume ' où ruissellent le lait" et le miel.
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
    \set stanza = #"7." \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIch }
>>