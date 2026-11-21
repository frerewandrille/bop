\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g ees
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Très vif"% 2 = 52
          g8 [a] b\breve*1/16 a8 g [a] b2 g\resp
          b8 [c] d\breve*1/16 e8 c [c] b2\resp
          b\breve*1/16 a8 g [g] c [c] b2\fermata
          \bar"|."
        } \tonVIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d8 [fis] g\breve*1/16 fis8 e [fis] g2 d
          g8 [a] b\breve*1/16 c8 a [a] g2
          g\breve*1/16 fis8 e [e] g [fis] g2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ils se "passent de l’éclat du soleil" et de la lu -- ne,
      car la "gloire de Dieu les a" il -- lu -- mi -- nés,
      "et l’Agneau est devenu" leur torche et leur flam -- beau_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 [c] d\breve*1/16 c8 b [d] d2 b
          d8 [d] g\breve*1/16 g8 g [fis] d2
          d\breve*1/16 c8 b [b] e [d] d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [d] g\breve*1/16 d8 e [d] g2 g\resp
          g8 [g] g\breve*1/16 g8 a [d,] g2\resp
          g\breve*1/16 d8 e [e] <a, a'> [d] <g, g'>2\fermata
        } \tonVIfh
      }
   >>
>>