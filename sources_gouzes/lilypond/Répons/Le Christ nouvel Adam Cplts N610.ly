\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17) indent = 0

armure = { \key ees \major \time 3/4 }

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
  { \armure \cadenzaOn \tonRIVef }

  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"(I V) 1." \set shortVocalName = \markup\right-align"1." 
    
  }
  \addlyrics
  { 
    \set shortVocalName = \markup\right-align"2." 
    \repeat unfold 15 \skip4
    "Il n’y a pas de plus grand amour '"
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Comme le Père m’a ai" -- "mé, ' moi aussi, je vous" ai ai -- més.
    "Demeurez en mon a" -- "mour ' pour que ma joie" soit en vous.
    "Aimez-vous les uns les autres ' comme" "moi, je vous" ai ai -- més.
    \set shortVocalName = ""
    \retrait "que de donner sa vie" pour ceux qu’on aime.
  }
  \addlyrics
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    
  }
  \addlyrics
  { 
    \set shortVocalName = \markup\right-align"5." 
    \repeat unfold 15 \skip4
   "pour nous conduire auprès du Père '"
  }
  \addlyrics
  { 
    \set stanza = #"(L) 5." \set shortVocalName = \markup\right-align"5." 
    "Le Christ a été mis à mort" se -- lon la chair,
    "mais il a été rendu à la" "vie,' par la puissance" de l’Es -- prit.
    "Une fois pour toutes, le Christ est" "mort pour" nos pé -- chés,
    \set shortVocalName = ""
    \retrait "par la puis" -- "sance de sa ré" -- sur -- rec -- tion.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"(II V) 6." \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = #"(Dox.) 7." \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" (Magn.) 8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIVeh }
>>