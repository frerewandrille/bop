\version "2.24.0"

\include "vowel-set.ly"
%\include "TonsRDef.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key d \minor \time 3/4 }
ptretrait = \once \override LyricText.X-offset = #3

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 5.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIif }
  \addlyrics 
  { 
    \set stanza = #"L." \set shortVocalName = \markup\right-align"L." 
    Bé -- ni "sois-tu pour Jean le Précurseur '"
    \repeat unfold 4 \skip4
    "Il se dresse comme un veil" -- "leur ' sur les" "murs de Jérusa" -- lem.
    "Il est la voix"
  }
  \addlyrics 
  { 
    \skip4 \skip4 \retrait "qui attend la ve" -- "nue" de son maître.
    \repeat unfold 4 \skip4
    \ptretrait "qui crie dans le dé" -- "sert : ' “Rendez droits les sentiers du" Sei -- "gneur !”"
  }
  \addlyrics 
  { 
    \set stanza = #"V." \set shortVocalName = \markup\right-align"V." 
    Tu es "sorti du sein du Père ' et tu as fait" "route" vers les hommes,
    "Et le Père a envoy" -- "é ' son" "ange devant" toi
    "Pour qu’il pré" -- "pare ' le chemin devant" ta face.
  }
  \addlyrics 
  { 
    \set stanza = #"Dox." \set shortVocalName = \markup\right-align"Dox." 
    Bé -- ni "sois-tu, ' Dieu d’Isra" -- "ël," no -- tre Père.
    "Béni sois-tu, Seigneur Jé" -- "sus ' qui viens visi" -- "ter ton" peuple.
    "Béni sois-tu,"
  }
  \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \repeat unfold 11 \skip4
    \ptretrait "Esprit de sainte" -- "té, ' en qui nous tressaillons d’al" -- lé -- gresse.
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIih }
>>