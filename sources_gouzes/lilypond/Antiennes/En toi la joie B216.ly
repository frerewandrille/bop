\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key c \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          e\breve*1/16 d8 [e] g [e] e2\fermata\breathe\allowBreak
          a\breve*1/16 g8 [a] c [b] a2\fermata \bar "|."
        }\tonIVef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          c\breve*1/16 b8 [c] d [d] c2 
          e \breve*1/16 e8 [e] e [d] <c e>2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "En toi, la" joie de no -- tre cœur, 
     "car tu as sauvé notre" â -- me de la mort_!
   }

   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 2/2 \cadenzaOn
          a\breve*1/16 a8 [a] b [b] a2 
          c\breve*1/16 b8 [c] a [g] a2
        }\tonIVeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          a\breve*1/16 a8 [a] e' [g] a2\fermata\breathe 
          a\breve*1/16 e8 [e] c [e] a,2\fermata
        }
      }
   >>
>>