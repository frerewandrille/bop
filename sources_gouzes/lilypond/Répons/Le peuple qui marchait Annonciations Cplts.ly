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
  
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Tu as multiplié l’allé" -- "gresse de ton" peuple,
    "Tu as fait éclater leur" "joie comme au jours de" la mois -- son_;
    "Car un enfant nous est né, ' un" "Fils nous a été don" -- né,
    "Dieu avec nous, ' Saint" "fort, ' Prince" de la paix.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Voici que la Vierge a conçu ' et qu’elle en" -- "fante un" fils_:
    "Il sera grand ' et on l’appelle" -- "ra Fils" du Très_- Haut.
    "En ce jour ' le Seigneur lui donne le" "trône de David son" père_:
    "Il régnera sur Jacob ' et son" "règne n’aura" pas de fin.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Joseph, fils de David, ' ne crains pas"
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set shortVocalName = "3." 
    \retrait "de prendre chez toi Ma" -- "rie, ' ton é" -- pouse,
    "puisque l’enfant qui est engendré en" "elle ' vient de" l’Es -- prit Saint_!
    "Elle enfantera un fils, ' et tu lui donneras le" "nom de Jé" -- sus,
    "car c’est lui qui sauvera son" "peuple de" ses pé -- chés.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Béni sois-tu, Père saint, ' toi dont la gloire rem" -- "plit tout l’uni" -- vers,
    "Béni sois-tu, Fils unique, '"
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \repeat unfold 3 { \skip4 }
    \retrait "qui viens apporter la" "paix à" no -- tre terre, 
    \set shortVocalName = "4." 
    "Béni sois-tu, Esprit, ' qui re" -- "pose sur le Messie de " Dieu,
    "Béni sois-tu, Dieu trois fois" "saint, dans le feu" de ta gloire.
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIph }
>>