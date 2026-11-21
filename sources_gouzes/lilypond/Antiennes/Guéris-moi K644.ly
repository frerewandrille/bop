\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 72
          b4 b a2 g fis\fermata\resp 
          e2 e4 d e2 g a\fermata\resp 
          a4 a b1 g2 a a1\fermata
          \bar"|."
        } \tonVIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          fis4 fis e2 e4 (cis) dis2 e c4 c c2 e fis fis4 fis fis1 e2 g fis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Gué -- ris_- moi, Sei -- gneur, et je se -- rai gué -- ri, 
      car tu es mon es -- poir.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d c2 b2 b2 g g4 g g (a) b2 d d4 d dis1 b2 e d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          b4 b c (d) e2 b\fermata\resp c2 c4 b a2 e' d\fermata\resp 
          d4 d b1 e2 c d1\fermata
        } \tonVIIbh
      }
   >>
>>