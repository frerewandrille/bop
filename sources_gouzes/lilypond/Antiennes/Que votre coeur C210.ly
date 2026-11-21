\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

%\transpose g bes
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 60
          g2 fis4 g e2 e4 fis d2 e g\resp g4 fis a2 a4 b g2\fermata
          \bar"|."
        } %\transpose bes g \tonVIIIbf
        \tonVIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d4 d c2 c4 c b2 c d d4 d e2 e4 fis d2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que vo -- tre cœur ne se trou -- ble pas. Je vous don -- ne ma paix.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 a4 b g2 g4 a fis (g) a2 b b4 a c2 c4 d b2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 d4 b c2 c4 a b2 a g\resp g'4 d a'2 a4 d, g2\fermata
        } %\transpose bes g \tonVIIIbh
        \tonVIeh
      }
   >>
>>