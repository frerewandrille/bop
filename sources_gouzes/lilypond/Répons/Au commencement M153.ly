\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff
<< \new Dynamics 
   {
     d4^\ppp^\< d c^\> c d2\!
     d4^\< d c d f2^\> d4 c d2 d\! \bar"|"
     d4^\< d d d c2^\! \agauche c4\rall^\> d2 d4 d d1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Très lent"% 2 = 52
         d4-> d c-> c d2->\resp
         d4-> d c-> d f2-> d4 c d2 d \bar"|"
         d4 d d d c2\resp c4 d2 d4 d d1\fermata
         \bar"|."
       } \transpose a d \tonIgf % absent dans l’original
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         bes4 bes a a bes2 bes4 bes a bes c2 bes4 a bes2 bes
         bes4 bes bes bes a2 a4 a2 bes4 bes a1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Au com -- men -- ce -- ment, Dieu cré -- a le ciel et la ter -- re,
     et l’Es -- prit de Dieu pla -- nait sur les eaux_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 g g g g2 g4 g f g a2 bes4 a g2 g
          g4 g f f a2 a4 fis2 g4 g fis!1
        } \transpose a d \tonIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          <g d'>4-> q q-> q q2->\resp q4-> q q-> q q2-> q4 q q2 q
          g4 g bes bes f'2\resp f4 d2 d4 d d1\fermata
        } 
      }
   >>
>>