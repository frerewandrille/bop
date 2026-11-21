\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose c bes,
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 58
          c4 c2\resp e4 e d d c2 b4 b a2 (gis!4 a) b2\fermata
          \bar"|."
        } \tonIIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          a4 a2 a4 a fis gis a2 f4 f e2. (fis4) gis!2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur, ne me ca -- che pas ton vi -- sa -- ge_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e4 e2 e4 e e e e2 d4 d c2 (b) e
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 a2\resp c4 c b b a2 d,4 d e1 e2\fermata
        } \tonIIIhh
      }
   >>
>>