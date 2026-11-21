\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose g f
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo  2 = 48
          g4 g2 g4 g a-> b b2\fermata\breathe\allowBreak
          b4-> a c b a g b2 a1 \breathe\allowBreak
          g4-> a a-> b a-> g g1\fermata\bar"|."
        }\tonVIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 d2 d4 e fis e fis2 fis4 e g fis e e e2 fis1 e4 e fis fis e e d1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Voi -- ci mon com -- man -- de -- ment_: 
      Ai -- mez_- vous les uns les au -- tres, com -- me je vous ai ai -- més.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          b4 b2 b4 b d e d2 d4 c e d c b b2 d1 b4 c d d c c b1
        }\tonVIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4 g2 fis4 e d-> c d2\fermata\breathe
          d4-> e c d e g c,2 d1 \breathe e4-> e d-> d e-> e g1\fermata
        }
      }
   >>
>>