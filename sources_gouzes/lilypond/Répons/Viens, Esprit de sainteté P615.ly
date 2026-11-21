\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silB = { \oneVoice r2 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Doux et mystérieux"
         d2 e4 fis2 g4 fis-> (e) d e2. \allowBreak\silB
         g4 a2-> b4 c-> (b) a g2 a4 b2.\resp
         d,2 e4 g2 a4 g8-> ([fis] e4) d e2.\fermata
         \bar"|."
       } \transpose a b \tonIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         b2 4 d2 4 d (b) b b2. s2 e4 fis2 g4 2 fis4 e2 fis4 g2.
         d2 b4 e2 fis4 e8 ([d] b4) b b2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Viens, Es -- prit de sain -- te -- té,
     rem -- plis nos cœurs de ton a -- mour,
     de ton feu, em -- bra -- se_- nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 g4 a2 b4 a (g) a b2. \silB b4 d2 4 e (d) d b2 d4 2.
          b2 a4 b2 d4 b2 a4 b2.
        } \transpose a b \tonIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          b2 e4 d2 b4 d-> (e) fis e2. s2 e4 d2-> 4 c-> (d) d e2 d4 g2.\resp
          g2 fis4 e2 d4 e8-> ([fis] g4) fis e2.\fermata
        } 
      }
   >>
>>