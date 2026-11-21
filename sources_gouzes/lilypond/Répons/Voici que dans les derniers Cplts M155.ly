\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key c \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose c bes,
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIIbf }

  \addlyrics
  { 
    \set stanza = #" 1." \set shortVocalName = \markup\right-align"1." 
    "Viens, Esprit Saint, des" qua -- tre vents_!
    "Souffle sur ces morts" et qu’ils vivent_!
    "Toi, qui as ressuscité Jésus d’en" -- tre les morts,
    "Tu rends la vie à ceux qui gisent dans l’ombre" de la mort.
  }
  \addlyrics
  { 
    \set stanza = #" 2." \set shortVocalName = \markup\right-align"2." 
    "Voici que je répandrai sur vous" une eau pure.
    "Je vous donnerai un" cœur de chair.
    "Je mettrai en vous" mon Es -- prit,
    "Vous serez mon peuple et moi, je serai" vo -- tre Dieu.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #" 3." \set shortVocalName = \markup\right-align"3." 
    "Fleuve de vie, jailli du trône" de l’A -- gneau,
    "Toi, qui pares l’Epouse de la beau" -- té de Dieu.
    "L’Esprit, l’eau et le sang sont témoins" du Sei -- gneur.
    "Nous puisons dans la joie aux sources" du sa -- lut.
  }
  \addlyrics
  { 
    \set stanza = #" 4." \set shortVocalName = \markup\right-align"4." 
    "Gloire au Père, qui nous a comblés de" son Es -- prit.
    "Gloire au Seigneur Jésus, qui ne nous laisse pas" or -- phe -- lins.
    "Gloire à l’Es -- prit d’amour, qui re -- pose" sur l’É -- glise.
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
  { \clef "bass" \armure \cadenzaOn \tonRVIIIbh }
>>