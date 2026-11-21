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
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    "Viens, Esprit Saint, des" qua -- tre vents_!
    "Souffle sur ces morts '" et qu’ils vivent_!
    "Toi, qui as ressuscité Jésus d’en" -- tre les morts,
    "tu rends la vie ' à ceux qui gisent dans l’ombre" de la mort.
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Le premier jour de la semaine, ' Jésus se tint au milieu" des dis -- ciples
    "et il souffla sur eux ' de son Souf" -- fle de feu.
    "Tous furent remplis de" l’Es -- prit Saint
    "et rendainet témoinge à la Ré" sur -- rec -- tion.
  }
  \addlyrics
  { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    "Aujourd’hui, ' le Seigneur répand son Esprit" sur l’É -- glise.
    "Aujourd’hui ' les apôtres sont rem" -- plis de joie.
    "Ils sont illuminés par un feu ' qui ne con" -- sum -- me pas.
    "Ils sont baptisés dans l’Esprit" et le feu.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    "Voici que je répands sur vous" une eau pure,
    "je vous donne un cœur de chair ' et mets en vous" mon Es -- prit_;
    "car il n’y a qu’un seul Corps et un" seul Es -- prit
    "et tous nous avons été baptisés ' en un" même Es -- prit
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    
  }
  \addlyrics
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    "Gloire au Père qui a engen" -- dré le Fils.
    "Gloire au Père et au Fils ' dans l’amour" de l’Es -- prit.
    "Gloire à l’Esprit qui nous rassemble en" en seul Corps
    "et nous conduit jusqu’à la vi" -- sion du Père_!
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
  { \clef "bass" \armure \cadenzaOn \tonRVIIIbh }
>>