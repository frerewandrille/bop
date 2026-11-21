\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 58
          g2 d'2. d4 c c bes a bes2 g2.\fermata\resp
          g4 g a bes2. bes4 a2 a g1\fermata
          \bar"|."
        } \tonIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 g2. g4 g g g g g (f) e2. e!4 e e d2. e!4 f2 f d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur_! Ma for -- ce m’a -- ban -- don -- ne 
      et la lu -- miè -- re de mes yeux_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 d2. d4 ees ees d c d (bes) c2.
          c4 c c bes2. bes4 d2 d4 (c) bes1
        } \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 bes2. bes4 c c g g g2 c,2.\fermata\resp 
          c4 c c g'2. g4 d2 d g1\fermata
        } 
      }
   >>
>>