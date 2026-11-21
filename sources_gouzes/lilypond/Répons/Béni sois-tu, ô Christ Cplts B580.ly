\version "2.24.0"
%\include "TonsRDef.ly"
\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17)

armure = { \key bes \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIIaf }

\addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Fais-nous revenir, Sei" -- gneur_:
    "tu t’es livré pour" nous_;
    "l’amour a été répandu dans nos" cœurs
    "par l’Esprit que tu nous as" don -- né.
   }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Voici que les na" -- tions
    "marchent vers ta Lu" -- mière,
    "et tu rassembles tous les" peuples
    "dans la clarté de ton" au -- rore.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Par ta Pâque, ' tu donnes à tous les" hommes
    "d’être réconciliés avec le" Père_;
    "par ta mort, ' tu rassembles en un seul" Corps
    "les enfants de Dieu dis" -- per -- sés.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Tu es au milieu de" nous
    "comme en un jour de" fête.
    "Ton regard est sur" nous,
    "et tu nous renouvelles par ton" a -- mour.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Comme par la faute d’un seul" homme,
    "la multitude est" morte,
    "par ta seule obéissance, ô" Christ,
    "la grâce a sura" -- bon -- dé.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"6. " \set shortVocalName = "6." 
    "Et nous qui, le visage décou" -- vert,
    "réfléchissons ta" Gloire,
    "tu nous transformes de gloire en" gloire
    "par ton Esprit ' qui nous fait fils" de Dieu.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"7. " \set shortVocalName = "7." 
    "Heureux le serviteur ' que tu as trouvé vigi" -- lant
    "lorsque tu es venu, ' dans la nuit de sa" mort_;
    "tu es entré chez lui pour sou" -- per,
    "lui près de toi ' et toi près" de lui_!
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"8. " \set shortVocalName = "8." 
    "Tu as fait abonder comme un" fleuve
    "ta sagesse dans le cœur des" saints_!
    "tu as été pour eux ' un ombrage pendant le" jour,
    "et comme la lumière des étoiles pendant" la nuit.
  }  
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #"9. " \set shortVocalName = "9." 
    "Béni sois-tu, Père des miséri" -- cordes,
    "Dieu de clémence et de toute consola" -- tion.
    "Béni soit ton Fils Jésus ' et l’Esprit qu’il nous a don" -- né,
    "hier, ' aujourd’hui, ' et pour l’éter" -- ni -- té_!
  }

  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIah }
>>