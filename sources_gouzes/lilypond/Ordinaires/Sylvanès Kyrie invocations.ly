\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "soprano"
  { \voiceOne \relative c'
    { \clef "treble" \armure \cadenzaOn % \tempo  2 = 96
      f\breve*1/8 bes4\resp c\breve*1/8 \allowBreak d8 bes2 \resp
      g8 g c bes bes2\fermata
      \bar"||"
    } 
  }
  \new Lyrics \lyricsto "soprano"
  {
    "Seigneur Jé" -- sus,
    "envoyé pour guérir les cœurs qui reviennent" 
    vers toi_:
    Sei -- gneur prends pi -- tié_!
  }
  \new Lyrics \lyricsto "soprano"
  {
    Ô Christ, "venu appeler les" pé -- cheurs_:
    Ô Christ, prends pi -- tié_!
  }
  \new Lyrics \lyricsto "soprano"
  {
    "Seigneur Jé" -- sus,
    "qui sièges à la droite du Père, où tu intercèdes"
    pour nous_:
    Sei -- gneur prends pi -- tié_!
  }
>>