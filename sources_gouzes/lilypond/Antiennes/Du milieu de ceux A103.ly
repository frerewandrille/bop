\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Paisible" 2 = 66
          a4 g a2. a4 c2 c4 b a2.\resp a4 c2 (a) a\resp
          d4 d c b a2\fermata\bar"|"
          e'2 e4 d c \allowBreak e e fis e (d) c d e2 (a,) a2.\fermata\resp
          b4 c2 b4 (c) a1\fermata
          \bar"|."
        } \tonIIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e2. fis4 g2 g4 g g2. fis4 g2 (e) fis a4 a g g fis2
          g2 g4 b a c b a g (fis) a b c2 (g) fis2. fis4 g2 g fis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Du mi -- lieu de ceux qui m’é -- crasent, ô Pè -- re,
      j’ai cri -- é vers toi.
      Tu es ma gloire et me re -- dres -- ses la tê -- te, 
      Al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 b c2. d4 e2 e4 d e2. d4 e2 (g) d fis4 fis e e d2
          e2 e4 fis e c c d c (d) e fis g2 (e) d2. d4 e2 e d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 e a2. d,4 <a a'>2 a'4 b c2.\resp c4 a1 d,2\resp
          d4 d a' a d2\fermata
          c2 c4 d a a a d, a' (b) a d c1 d2.\fermata\resp d,4 a'2 c d1\fermata
        } \tonIIIbh
      }
   >>
>>