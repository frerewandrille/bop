\version "2.24.0"
%\include "TonsDef.ly"

\transpose f ees
\new ChoirStaff  
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key c \major \cadenzaOn 
          \tempo "Allant" 2 = 84
          f4 f-> f a-> c b2.\fermata \breathe
          g4 g-> g a-> g g2 \fermata \bar "|."
        } \tonVIIIdf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          d4 d d f e g2. d4 e e f d d2
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Le4 Sei -- gneur s’est le -- vé,2.
     lu4 -- miè -- re  des cœurs droits_!2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \cadenzaOn 
          c4 c c c c d2. b4 c c c c b2
        }\tonVIIIdh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          a4 a-> a f-> a g2.\fermata\breathe
          g4 c,-> c f-> g g2\fermata
        }
      }
   >>
   
>>