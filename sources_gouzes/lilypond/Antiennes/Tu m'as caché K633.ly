\version "2.24.0"
%\include "TonsDef.ly"

\transpose b a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo  2 = 46
          b2 b4 b g a b2\breathe\allowBreak e,4 fis g2 a4 g fis2 e1\fermata
          \bar"|."
        }\transpose a b \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 b4 b c c d2 c4 c b2 e4 e d2 b1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto "soprano"
   {
      Tu m’as ca -- ché, Sei -- gneur, au se -- cret de ta fa -- ce.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          g2 fis4 fis e e fis2 a4 a g2 a4 a b (a) g1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 d4 d c c b2\breathe a4 a e' (d) c c b2 e1\fermata
        }\transpose a b \tonIeh
      }
   >>
>>