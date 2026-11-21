\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 63
          bes2 g2.\fermata\resp g4 g-> g bes2 bes4 bes g2\resp 
          aes aes4 bes g2\fermata g\fermata
          \bar"|."
        } \transpose a g \tonXaf
        %\tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g2. g4 g g g2 g4 g g2 f f4 f g2 g
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, que ne soient pas con -- fon -- dus 
      ceux qui t’es -- pè -- rent_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 e2. e!4 e e d2 d4 d e!2 c c4 d e!2 e
        } \transpose a g \tonXah
        %\tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 <c, c'>2.\fermata\resp <c c'>4 q-> q g'2 g4 g <c, c'>2\resp 
          f2 f4 f <c c'>2\fermata q\fermata
        } 
      }
   >>
>>