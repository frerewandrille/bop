\version "2.24.0"

\include "vowel-set.ly"
\include "TonsRDef.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key d \minor \time 3/4 }


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
  { \armure \cadenzaOn \tonRVIpf }
  
  \addlyrics
  { 
    \set stanza = #" (Le 24) 1." \set shortVocalName = "1." 
    "En Sion, ' la voix des guetteurs s’é" -- "lève sur les rem" -- parts.
    "Dans les ruines de Jérusa" -- "lem, éclatent des" chants de joie,
    "car ils voient, ' les" "yeux dans les" yeux
    "le Seigneur de la gloire '"
  }
  \addlyrics
  { 
    \repeat unfold 11 { \skip4 }
    \retrait "qui vient nous visi" -- "ter dans" no -- tre chair.
  }
  \addlyrics
  { 
    \set stanza = #"(Le 25) 2." \set shortVocalName = "2." 
    "Tu as multiplié l’allé" -- "gresse de ton" peuple,
    "tu as fait éclater leur" "joie comme au jours de" la mois -- son_;
    "Car un enfant nous est né, ' un" "Fils nous a été don" -- né,
    "Dieu avec nous, ' Saint" "fort, ' Prince" de la paix.
  }
  \addlyrics
  { 
    \set stanza = #"3." \set shortVocalName = "3." 
    "Voici que la Vierge a conçu ' et qu’elle en" -- "fante un" fils_:
    "Il sera grand ' et on l’appelle" -- "ra Fils" du Très_- Haut.
    "En ce jour ' le Seigneur lui donne le" "trône de David son" père_:
    "Il régnera sur Jacob ' et son" "règne n’aura" pas de fin.
  }
  \addlyrics
  { 
    \set stanza = #"4." \set shortVocalName = "4." 
    "En ce jour, ' le Seigneur"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set shortVocalName = "4." 
    \retrait "a établi un Pasteur à la" "tête de son" peuple_:
    "il fera paître Israël dans la sécuri" -- "té près des eaux" du re -- pos.
    "Car Dieu sera leur Dieu ' et" "eux seront son" peuple_;
    "l’Alliance nouvelle est gra" -- "vée dans la" chair du Christ.
  }
  \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" (Dox.) 5." \set shortVocalName = "5." 
    "Béni sois-tu, Père saint, ' toi dont la gloire rem" -- "plit tout l’uni" -- vers,
    "Béni sois-tu, Fils unique, '"
  }
  \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \repeat unfold 3 { \skip4 }
    \retrait "qui viens apporter la" "paix à" no -- tre terre, 
    \set shortVocalName = "5." 
    "Béni sois-tu, Esprit, ' qui re" -- "pose sur le Messie de " Dieu,
    "Béni sois-tu, Dieu trois fois" "saint, dans le feu" de ta gloire.
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIph }
>>