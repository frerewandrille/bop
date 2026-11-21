\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "Calme"% 2 = 69
         \repeat volta 3 {
           \partial8 e8 a [g] a4 e8 [g a a] g b a g e4 e \bar"|"
         }
         \alternative {
           { c'8 b a4 g a\fermata }
           { c8 b a4 g a\fermata }
         }
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \repeat volta 3 {
           e8 e [e] e4 e8 [e e e] e e e e c4 c
         }
         \alternative {
           { g'8 g e4 e e }
           { g8 g e4 e e }
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
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          \repeat volta 3 {
            e8 c' [b] c4 a8 [b c c] b d c b a4 a 
          }
          \alternative {
            { e'8 d c4 b c }
            { e8 d c4 b c }
          }
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \repeat volta 3 {
            e8 e [e] e4 e8 [e e e] e e e e a4 a
          }
          \alternative {
            { c,8 g' a4 e a,\fermata }
            { c8 g' a4 e a,\fermata }
          }
        } 
      }
   >>
>>