\version "2.24.0"
%\include "TonsDef.ly"

rall = #(make-dynamic-script 
         (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff  
<< \new Dynamics 
   {
     a2^\< a4 g\> f f g2\! \breathe 
          g4^\< g bes2\> bes4 bes g2 g \!\breathe \allowBreak
          a4^\< a c2\> c4 c a2\! \breathe
          d4^\< d \agauche c2\rall\> a4  g a2  \!\bar "||"
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \cadenzaOn 
          \tempo "Calme, berceur" 2 = 58
          a2 a4 g f f g2 \breathe 
          g4 g bes2 bes4 bes g2\fermata g\fermata\breathe \allowBreak
          a4 a c2 c4 c a2 \breathe
          d4 d c2 a4 \fermata g\fermata a2 \fermata\bar "||"
        } \tonVIcf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          f2 f4 e d d e2 e4 e g2 g4 f e2 e
          f4 f e2 e4 e f2 f4 g a2 f4 e f2
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Comme2 un4 pe -- tit en -- fant2 dans4 les bras2 de4 sa mè2 -- re,
     j’ai4 gar -- dé2 près4 de toi2 le4 si -- lence2 et4 la paix.2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \cadenzaOn 
          c2 c4 c a a c2 c4 c d2 d4 d c2 c
          c4 c c2 c4 c d2 d4 d e2 d4 d c2
        }\tonVIch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          f2 f4 c d d c2 \breathe c4 c g'2 g4 g c,2\fermata c\fermata\breathe
          f4 f a2 a4 a d,2 \breathe 
          bes'4 bes a2 bes4\fermata bes\fermata f2 \fermata
        }
      }
   >>
   
>>