\version "2.24.0"

\include "vowel-set.ly"

armure = { \key a \minor }
alleluia = {
  << 
    \new Staff \with {\remove Time_signature_engraver }
    { \new Voice = "soprano" \key g \major \cadenzaOn 
      \relative c' {d8 ([g]) g2 (a8 [b] g2 a8 [g]) g4. (a8 b [g]) g4. (a8 g [c] a [b] a4 g2\fermata) \bar":|." } }
    \new Lyrics \lyricsto "soprano" { Al -- lé -- lu -- ia_! }
  >>
}

\transpose d bes, \alleluia
\transpose d c \alleluia
\transpose d d \alleluia
