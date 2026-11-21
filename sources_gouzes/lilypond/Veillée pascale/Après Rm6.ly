\version "2.24.0"

%%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key d \minor }
retrait = \once \override LyricText.X-offset = #retrait

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose f g
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIgf
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Rendez grâce au Sei" -- "gneur :" Il est bon_!
    "Éter" -- "nel est" son a -- mour_!
    "Oui, que le" dise Is -- ra -- ël_:
    "Éter" -- "nel est" son a -- mour_!
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Le bras du Sei" -- gneur \skip4 se lève,
    "le bras du Sei" -- gneur \skip4 est fort_!
    "Non, je ne mourrai" pas, je vi -- vrai
    "pour annoncer les ac" -- tions du Sei -- gneur.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "La pierre qu’ont reje" -- "tée les" bâ -- tis -- seurs
    "est deve" -- "nue la" pier -- re d’angle_:
    "c’est là" l’œuvre du Sei -- gneur,
    "la mer" -- "veille de" -- vant nos yeux.
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIgh
  }
>>