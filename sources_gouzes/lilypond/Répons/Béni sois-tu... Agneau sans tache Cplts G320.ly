\version "2.24.0"

\include "vowel-set.ly"
%\include "TonsRDef.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key d \minor \time 3/4 }

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
  { \armure \cadenzaOn 
    <<
      \tonRVIif
    >>
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    Bé -- ni "sois-tu pour Jean le Précurseur ' qui attend la ve" -- "nue" de son maître.
    "Il se dresse comme un veil" -- "leur ' sur les" "murs de Jérusa" -- lem.
    "Il est la voix qui crie dans le dé" -- "sert : ' “Rendez droits les sentiers du" Sei -- "gneur !”"
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    Bé -- ni "sois-tu pour Jean qui a scruté la nuit ' cher" -- "chant son" Bien- -- Ai -- mé.
    "Il l’a enten" -- "du, ' sau" -- "tant sur les mon" -- tagnes,
    "Bondissant sur les col" -- "lines ' pour chercher la brebis" per -- due.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    Bé -- ni "sois-tu pour Jean le Baptiste ' qui a montré l’Agne" -- "au" vé -- ri -- table.
    "Il a reconnu dans le sein de Mar" -- "ie ' l’espé" -- "rance des na" -- tions,
    "Et son cœur a bondi de" -- "joie ' dans la puissance de" l’Es -- prit.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    Tu es "sorti du sein du Père ' et tu as fait"  "route" vers les hommes,
    "Et le Père a envoy" -- "é ' son" "ange devant" toi
    "Pour qu’il pré" -- "pare ' le chemin devant" ta face.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"Dox. " \set shortVocalName = \markup\right-align"Dox." 
    Bé -- ni "sois-tu, ' Dieu d’Isra" -- "ël," no -- tre Père.
    "Béni sois-tu, Seigneur Jé" -- "sus ' qui viens visi" -- "ter ton" peuple.
    "Béni sois-tu, Esprit de sainte" -- "té, ' en qui nous tressaillons d’al" -- lé -- gresse.
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn 
    <<
      \tonRVIih
    >>
  }
>>