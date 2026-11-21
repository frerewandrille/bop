\version "2.24.0"
%\include "TonsDef.ly"

\transpose b a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo  2. = 52
          b2. b4^> g a b2 g4 c2 c4 b2.\breathe\allowBreak 
          d4^> b c d^> d d c^> c c b2.\breathe\allowBreak
          b4^> b b b2 b4 c2 c4 b2.\fermata
          \bar "|."
        }\cadenzaOn \tonVIif
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          g2. g4 e e g2 e4 fis2 fis4 g2. g4 g a a a a a a g fis2. 
          fis4 fis fis g2 g4 g2 fis4 g2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Que je ren -- de grâce à ton a -- mour_: 
      Tu as ti -- ré de l’a -- bî -- me des morts ce -- lui qui vit et croit en toi.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          d2. d4 c c d2 c4 d2 d4 d2. d4 e e fis fis fis e e e dis2.
          dis!4 dis dis e2 e4 e2 d!4 d2.
        }\cadenzaOn \tonVIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g2. g4_> c c g2 c4 a2 a4 g2.\breathe
          b4_> e, a <d, d'>_> <d d'> q a'_> a a b2.\breathe
          b4_> b b e,2 e4 a2 a4 g2.\fermata
        }
      }
   >>
>>