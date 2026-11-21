\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 18) indent = 0

armure = { \key d \major \time 3/4 }

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
  { \armure \cadenzaOn \tonRIhf }

  \addlyrics
  { 
    \set stanza = " (Le 25) 1." \set shortVocalName = \markup\right-align"1." 
    "Tu es venu chercher la brebis per" -- due,
    "toi, le bon Ber" -- ger, "ami des" hommes.
    "Pour notre salut, ' tu es descendu sur la" terre,
    "tu as pris sur tes épaules ' le pé" -- "ché du" monde.
  }
  \addlyrics
  { 
    \set stanza = "(Le 29) 2." \set shortVocalName = \markup\right-align"2." 
    "Les patriarches ont désiré voir ton" jour,
    "les prophètes ont annon" -- cé "ta ve" -- nue,
    "Jean-Baptiste t’a précédé ' et il t’a recon" -- nu,
    "et Marie t’a por" -- "té en son" sein.
  }
  \addlyrics
  { 
    \set stanza = "(Le 30) 3." \set shortVocalName = \markup\right-align"3." 
    "Tu étais dans le sein du Père, ô" Christ,
    "et tu es ve" -- nu "dans le" monde.
    "Tu as pris chair de la Vierge Ma" -- rie,
    "et nous avons" "vu ta" gloire.
  }
  \addlyrics
  { 
    \set stanza = "(Le 31) 4." \set shortVocalName = \markup\right-align"4." 
    "Bénie soit ta venue parmi nous, ô" Christ.
    "Béni soit ton a" -- mour "pour les" hommes.
    "Alors que nous étions pécheurs, ' tu nous as ai" -- més,
    "tu nous sauves et nous ra" -- "mènes auprès du" Père.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
    "Marie est devenue le ciel nou" -- veau
    "sur lequel re" -- pose "le Fils de" l’Homme.
    "Elle est l’arche de l’Alliance nou" -- velle,
    "en elle brille la" "gloire du Sei" -- gneur.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = " (Dox.) 6." \set shortVocalName = \markup\right-align"6." 
    "Gloire au Père, ' source de toute sainte" -- té.
    "Gloire au Seigneur Jé" -- sus, "ami des" hommes.
    "Gloire à l’Esprit ' qui fait de nous des fils de" Dieu.
    "Trinité bienheu" -- "reuse, gloire à" toi.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIhh }
>>