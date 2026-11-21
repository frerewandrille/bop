\version "2.24.0"
%\include "TonsDef.ly"
%%\include "TonsRDef.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e4 fis8 [g] a4 a g fis e2 \bar"|"
         a4 b8 [c] d2\resp c4 b a8 ([b]) c4 b8 ([a]) g2\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e8 [e] e4 e e e8 ([dis]) b2 fis'4 g8 [a] b2 
         g4 g g8 ([fis]) e4 fis d2
       } \transpose a b \tonVIgf
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pi -- tié pour nous, Jé -- sus très saint_! 
     En ton a -- mour, tu as souf -- fert pour nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 a8 [b] c4 c b a g2 d'!4 d8 [d] d2 e4 d c8 ([d]) e4 d8 [(c]) b2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 e8 [e] e4 e e b e2 d4 d8 [d] g2\resp
          g4 g8 ([fis]) e ([d]) c4 d g2\fermata
        }  \transpose a b \tonVIgh
      }
   >>
>>

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIIff }
  \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIIfh }
>>