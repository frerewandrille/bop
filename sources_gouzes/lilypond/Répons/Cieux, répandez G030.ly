\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 56
         f2 g4 a a2 d c4 bes a2 g2.\resp a4 bes a g2 f4 e f e d2\fermata
         \bar"|."
       } \tonIdf %pas de ton dans l’original
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c2 d4 e f2 bes g4 g g (f) e2. f4 f f e2 d4 c d c8 ([bes]) a2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Cieux, ré -- pan -- dez vo -- tre jus -- ti -- ce,
     que des nu -- ées vien -- ne le sa -- lut_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 bes4 c c2 f e4 d c (d) e2. c4 d c c2 a4 c bes g a2
        } \tonIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 f f2 bes, c4 c f2 c2.\resp
          f4 f f c2 d4 a d g, d'2\fermata
        } 
      }
   >>
>>