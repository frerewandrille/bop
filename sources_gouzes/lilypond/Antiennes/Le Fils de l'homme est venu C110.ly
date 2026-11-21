\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key e \minor \cadenzaOn \tempo "Allant" 2 = 52
          d,2 e4 g a2 a \breathe a4 a g a b2 a4 g a2\fermata\breathe \allowBreak
          a a4 a g2 e e1 \fermata  \bar "||" %\noBreak
        }\tonIIIbf
        %\tonIVbf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          d2 e4 g fis2 fis fis4 fis e fis g2 e4 e fis2
          fis fis4 fis e2 fis
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      Le2 Fils4 de l’hom2 -- me est4 ve -- nu cher -- cher2 et4 sau -- ver2
      ceux qui4 é -- taient2 per -- dus.1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key e \minor \cadenzaOn 
          d,2 e4 g d'2 d d4 d b c d2 c4 b d2 d d4 d b2 c b1
        } \tonIIIbh
        %\tonIVbh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          d2 e4 g d2 d \breathe d4 d e a g2 a4 e d2\fermata \breathe
          d d4 d e2 a e1\fermata
        }
      }
   >>
   
>>