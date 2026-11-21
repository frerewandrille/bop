\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a\minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
         f4 f2 4 4 2 e4 4 f2 f4\< g aes2\> g f\!
         f4^\markup{\dynamic pp "en écho"}\< g aes2\> g f\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Grave mais allant" 2 = 88
         f4 f2-- 4 4 2-- e4 4 f2\fermata\resp f4 g aes2 g f\fermata\resp 
         f4 g aes!2 g f\fermata
         \bar"|."
       } \transpose fis a \tonXcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c4 2 4 4 2 4 4 d2 d4 e ees2 e c
         d4 e ees2 e c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Il est comme un ar -- bre plan -- té près du cours des eaux, près du cours des eaux.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 2 4 4 g2 4 a4 a 2 4 c4 2 2 a2
          4 c4 2 2 a
        } \transpose fis a \tonXch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 2-- 4 4 c2-- 4 a d2\fermata\resp 4 c aes2 c f\fermata\resp
          d4 c aes!2 c f\fermata
        } 
      }
   >>
>>