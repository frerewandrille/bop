\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "Calme"% 2 = 69
         \repeat volta 3 {
           g2 g4 fis g2 \allowBreak e4 fis g g a a b a g2 g \bar"|"
         }
         \alternative {
           { e4 fis g2 g fis\fermata }
           { e4 fis g2 g fis\fermata }
         }
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \repeat volta 3 {
           e2 e4 e e2 e4 e e e e e e e e2 e
         }
         \alternative {
           { e4 d d2 d d }
           { e4 d d2 d d }
         }        
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     A -- gneau de Dieu, 
     qui en -- lè -- ves les pé -- chés du mon -- de,
     %\set stanza = "1 & 2. " 
     prends pi -- tié de nous.
     %\set stanza = "3. " 
     don -- ne_- nous la paix.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \repeat volta 3 {
            b2 b4 a b2 g4 a b b c c d c b2 b
          }
          \alternative {
            { g4 a b2 b a }
            { g4 a b2 b a }
          }
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \repeat volta 3 {
            e2 e4 e e2 e4 e e e a, a a a e'2 e
          }
          \alternative {
            { e4 d g,2 g d'\fermata }
            { e4 d g,2 g d'\fermata }
          }
        } 
      }
   >>
>>