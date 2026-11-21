\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff  
<< \new Dynamics 
   {
     fis4^\< fis fis a g\! fis g2^\> (a4 g) fis2\! \breathe\allowBreak
     a4^\< a a g fis2 g4 fis e2\!\bar"||"
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \cadenzaOn 
          fis4 fis fis a g fis g2-> (a4 g) fis2 \breathe\allowBreak
          a4 a a g fis2^\markup{\italic rall.} g4 fis e2\fermata\bar"||"
        } \tonIIcf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          d4 d d d d d d1 d2 fis4 fis fis g d2 d4 d b2
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Bé4 -- ni sois -- tu, no -- tre Pè1 -- re,2 
     qui4 nous as bé -- nis2 dans4 le Christ_!2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \cadenzaOn 
          a4 a a c b a b2 (c4 b) a2 c4 c c b a2 b4 a g2
        }\tonIIch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          d4 d d d g d g2-> (fis4 g) d2 \breathe
          d4 d d d d2 g4 d e2\fermata
        }
      }
   >>
   
>>