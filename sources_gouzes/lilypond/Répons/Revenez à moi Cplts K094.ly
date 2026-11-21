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
  { \armure \cadenzaOn \tonRIVdf }

  \addlyrics
  { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    "Voici maintenant le temps favo" -- rable_:
    "Déchirez votre" "cœur, et non vos vête"ments,
    "Pour ne pas recevoir en" "vain la grâce du" par -- don.
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Voici maintenant le jour du sa"lut_:
    "Convoquez l’assemblée du" "peuple devant le Sei" -- gneur.
    "Qui sait ? S’il revenait et nous com" -- "blait de sa misé" -- ri -- corde_?
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    "Gloire à toi, notre Père, qui nous ouvre un jour nou" -- veau
    "Pour que nous entrions avec ton" "Fils au lieu de ton re" -- pos
    "Dans le pardon de l’Es" -- "prit qui vient tourner notre cœur" vers toi.
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    
  }
  \addlyrics
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIVdh }
>>