\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 54
          c2 b4 a b2 e,4\resp e a2 g4 f g2 e\resp 
          e4 e f2 f4 \allowBreak f f2 g4 a e1\fermata
          \bar"|."
        } \tonIVef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 d4 c b2 c4 c c (d) e d e2 e e4 e d2 d4 d d2 b4 b cis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Qui vous ac -- cueil -- le, 
      c’est moi qu’il ac -- cueil -- le,
      et le Pè -- re qui m’a en -- vo -- yé.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 a g2 a4 a a2 b4 a b2 cis cis!4 cis a2 a4 a a2 g4 g a1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a2 a4 a e'2 a4\resp g f2 e4 f e2 a\resp
          a4 a d,2 c4 c b2 e4 e a,1\fermata
        } \tonIVeh
      }
   >>
>>