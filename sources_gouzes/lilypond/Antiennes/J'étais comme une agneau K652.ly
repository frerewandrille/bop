\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose b a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 52
          b2 b4 b d d b2 \resp b4 b c2 c4-- c-- b1\fermata\resp 
          b4 b b b e,2 e4 (fis) g2\fermata g\fermata
          \bar"|."
        } \transpose a b \tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g4 g b b g2 g4 g e2 e4 fis g1 g4 g g g e2 e e e
        }    
      }
   >>
   \new Lyrics \lyricsto "soprano"
   {
      J’é -- tais comme un a -- gneau qu’on em -- mène à la mort 
      et qui n’ou -- vre pas la bou -- che.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 d d d e2 e4 d c2 c4 c d1 d4 d d d c2 c b b
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 g fis fis e2\resp e4 e a2 a4-- aes-- g1\fermata\resp 
          g4 g g g a2 a e\fermata e\fermata
        } \transpose a b \tonIch
      }
   >>
>>