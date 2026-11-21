\version "2.24.0"

\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17) indent = 0

armure = { \key f \major \time 3/4 }
\defineBarLine "|" #'("|" "" "")
\defineBarLine "|." #'("|." "" "")

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new StaffGroup
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \relative c'' {
    << { c\breve d s8 c4 \bar"|" c\breve bes s8 a2 } \\
       { f\breve f g8 a4 f\breve d e8 f2 } >>
    \bar"|."
    }
  }

  \addlyrics
  { 
    \set stanza = #"Lu (1.)" \set shortVocalName = \markup\right-align"1." 
    "Ce Jésus que vous avez fait mourir en le clou" -- "ant sur u" -- ne croix,
    "Dieu l’a fait Seigneur et Christ ' en le délivrant de la" "mort et des" en -- fers.
  }
  \addlyrics
  { 
    \set stanza = #"Ma (2.)" \set shortVocalName = \markup\right-align"2." 
    "Le Dieu l’Abraham, Isaac et Jacob ' a glori" -- "fié son ser" -- vi -- teur,
    "ce Jésus que vous avez livré, ' mettant à mort le" "Prince de" la Vie.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"Me (3.)" \set shortVocalName = \markup\right-align"3."
    "En Jésus, Dieu a acoompli ce qu’il avait annon" -- "cé par les" pro -- phètes_:
    "le Christ devait souffrir pour en" -- "trer dans" la gloire.
  }
  \addlyrics
  { 
    \set stanza = #"Je (4.)" \set shortVocalName = \markup\right-align"4." 
    "Il n’y a pas sous le ciel ' d’autre" "nom donné" aux hommes
    "par lequel nous puissions être sau" -- "vés de" la mort.
  }
  \addlyrics
  { 
    \set stanza = #"Ve (5.)" \set shortVocalName = \markup\right-align"5." 
    "La pierre rejetée des bâtisseurs est deve" -- "nue la pier" -- re d’angle
    " sur laquelle nous sommes édifiés en temple vi" -- "vant de l’Es" -- prit Saint.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"Sa (6.)" \set shortVocalName = \markup\right-align"6." 
    "Dieu n’a pas abandonné le Christ au pou" -- "voir des" en -- fers_:
    "par sa résurrection, il nous a fait connaître le che" -- "min de" la vie.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" Dox (7.)" \set shortVocalName = \markup\right-align"7." 
    "Gloire au Père, au" "Fils, au Saint" Es -- prit,
    "au Dieu qui est, qui était et qui vient, '"
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \repeat unfold 4 \skip4 
    \retrait "pour les siècles des" siècles._' A -- men_!
  }


  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \relative c' {
    << { a\breve bes s8 c4 \bar"|" a\breve bes s8 c2 } \\
       { f,\breve bes, s8 f'4 f\breve g s8 f2 } >>
    }
  }
>>