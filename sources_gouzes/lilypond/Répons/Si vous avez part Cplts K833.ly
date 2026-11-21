\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17)

armure = { \key bes \major \time 3/4 }

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
  { \armure \cadenzaOn \tonRIIdf }

\addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Je ne veux connaître que Jésus, mon" Sei -- gneur,
    "avec la puissance de sa Résurrection '"
   }
\addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \repeat unfold 3 { \skip4 }
    \retrait "et la communion à ses" sou -- frances_;
    \set shortVocalName = "1." 
    "je veux lui devenir conforme dans" la mort
    "afin de ressusciter avec lui d’en" -- tre les morts.
   }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Luttez d’un cœur unanime ' pour la Foi de l’É" -- van -- gile_:
    "la grâce de Dieu vous fera tenir dans le" com -- bat,
    "car il vous a été donné ' non seulement de croire " en lui,
    "mais encore de souf" -- frir pour lui.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Je complète en" ma chair
    "ce qui manque aux souffrances" du Christ_;
    "et je trouve ma joie ' dans les souffrances que" j’en -- dure
    "pour son Corps qui" est l’É -- glise.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Pour moi, ' que jamais je ne me glo" -- ri -- fie,
    "sinon dans la Croix de notre Seigneur Jé" -- sus_- Christ,
    "qui a fait du monde ' un crucifié" pour moi,
    "et de moi un crucifié" pour le monde.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #"5. " \set shortVocalName = "5."
    "Le Christ a été crucifié ' en raison de sa" fai -- blesse,
    "mais il est vivant ' de par la Puissance" de Dieu.
    "Et nous qui, en lui, som" -- mes faibles,
    "nous serons vivants avec lui ' par la Puissan" -- ce de Dieu.
  }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #"6. " \set shortVocalName = "6."
    "Gloire à toi, Père Saint, ' qui nous invites au " Roy -- aume.
    "Gloire à ton Fils, ' qui souffre et meurt dans no" -- tre chair.
    "Gloire à l’Esprit ' qui nous fait entrer dans" sa Pâque,
    "pour que nous mourions en sa Mort ' et vivions " de sa Vie.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #"7. " \set shortVocalName = "7." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIdh }
>>