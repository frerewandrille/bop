\version "2.24.0"
%\include "TonsDef.ly"


\transpose d b,
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn \tempo "Large" 2 = 60
          d2^\pp g,1\breathe g4 g g a bes2 bes4 bes g2\fermata g\fermata\breathe\allowBreak
          c2. c4 c c c2 c4 c bes2 a a\fermata\breathe\allowBreak 
          d4 d^\< b2 c4 d ees2^\> ees4 \allowBreak
          c bes1 a2 a b1\fermata\! b\fermata\bar"|."
        }\transpose g c' \tonIcf
        %\transpose g bes\tonIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 ees1 ees4 ees ees ees g2 g4 g g2 g g2. g4 g g g2 g4 g g2 g fis
          d4 d g2 g4 g g2 g4 g g1 g2 fis! g1 g
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur, ma part d’hé -- ri -- tage et ma cou -- pe_! 
     L’hom -- me ne vit pas seu -- le -- ment de pain, 
     mais de tou -- te pa -- ro -- le qui sort de ta bou -- che.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          bes2 c1 c4 c c c d2 d4 d ees2 ees ees2. ees4 c d ees2 ees4 ees d2 c d
          a4 a g2 c4 b c2 c4 c d1 d2 d d1 d
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 c,1\breathe c4 c c c <g g'>2 q4 q <c c'>2\fermata q\fermata\breathe
          ees2. ees4 ees d c2 c4 c g'2 ees d\fermata\breathe
          fis4 fis g2 ees4 d c2 c4 ees d1 d2 d g1 g
        }\transpose g c' \tonIch
        %\transpose g bes \tonIIdh
      }
   >>
>>