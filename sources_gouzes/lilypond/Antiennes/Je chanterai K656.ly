\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 72
          \partial2 e2 a c b a g2. (f4) e2\fermata\resp
          e a c e d4 (c) b2 b a1\fermata
          \bar "|."
        } \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial2 c2 e e f e e (d) c e c4 (d) e2 f4 (g) a2 a gis e1
        }          
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Je chan -- te -- rai ta for -- ce_: Tu es le Dieu de mon a -- mour.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure\cadenzaOn
          \partial2 a2 a a a4 (b) c2 b (a4 b) a2 
          c4 (b) a2 a a a4 (b8 [c]) d2 e4 (d) c1
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial2 a4 (b) c (b) c (e) d2 c4 (d) e2 (f4 g) a2\fermata\breathe
          a4 (g) f2 e d4 (e) f2 f e <a, a'>1\fermata
        }
      }
   >>
>>