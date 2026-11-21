\version "2.24.0"

\include "vowel-set.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \tempo "Ton dominicain" \armure \relative c'' { 
    \cadenzaOn a\breve*1/8 b4\resp
    a8 g [a] b4\resp b8 a ([d] b [a g b]) g4 a2\fermata \bar"|."}
  }
  \new Lyrics \lyricsto "president"
  { "Bénissons le Sei" -- gneur, 
    al -- lé -- lu -- ia, al -- lé -- lu -- ia_! }
>>
