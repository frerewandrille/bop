\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key c \major \time 3/4 }
voyelle = \once \override LyricText.X-offset = #center-on-vowel

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIIpf }

\addlyrics
   { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    "Le Christ s’est fait obéis" -- "sant ' jusqu’à" la mort.
    "C’est pourquoi Dieu l’a exal" -- "té ' et fait" Sei -- gneur.
    "Que se réjouisse le" "ciel ' et qu’exulte" la terre,
    \voyelle "qu’aux enfers, l’Ennemi ' se pros" -- "terne de" -- vant lui_!
   }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Le Christ a foulé aux" "pieds les puissances de" la mort,
    "par les armes de sa" "croix ' il a brisé les verrous des" en -- fers.
    "Il entraîne toute principau" -- "té ' dans son cortège tri" -- om -- phal.
    "Il libère les prisonniers des té" -- "nèbres ' sur les cieux" des cieux_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    
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
  { \clef "bass" \armure \cadenzaOn \tonRIIph }
>>