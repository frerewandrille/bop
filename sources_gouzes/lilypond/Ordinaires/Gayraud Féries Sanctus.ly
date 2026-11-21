\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "Vif" 2 = 69
         \partial 8 a4 g a c8 b a4 b8 b a g a4. \bar"|"
         e8 a4 a8 [g] a a g a b4 \allowBreak c8 b a (g) a4 \allowBreak 
         \silN c8 b a4 b8 b a g a4.\bar"|"
         e8 a4 a8 a g a b4 \allowBreak c8 b a g a4 \allowBreak 
         \silN c8 b a4 b8 b a g a2\fermata \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e e g8 g e4 g8 g e e e4.
         e8 e4 e8 [e] e e e e e4 e8 e e4 e s g8 g e4 g8 g e e e4.
         e8 e4 e8 e e e e4 e8 e e e e4 s g8 g e4 g8 g e e e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Saint, saint, saint, le Sei -- gneur, Dieu de l’u -- ni -- vers_!
     Le ciel et la ter -- re sont rem -- plis de ta gloi -- re.
     Ho -- san -- na au plus haut des cieux.
     Bé -- ni soit ce -- lui qui vient au nom du Sei -- gneur.
     Ho -- san -- na au plus haut des cieux.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 b c e8 d c4 d8 d c b c4. 
          e,8 c'4 c8 [b] c c b c d4 e8 d c (b) c4 \silN e8 d c4 d8 d c b c4.
          e,8 c'4 c8 c b c d4 e8 d c b c4 \silN e8 d c4 d8 d c b c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 e a c,8 g' a4 g8 g a e a,4.
          e'8 e4 e8 [e] e e e e e4 e8 e e4 a s c,8 g' a4 g8 g a e a,4.
          e'8 e4 e8 e e e e4 e8 e e e a4 s c,8 g' a4 g8 g a e a,2
          \fermata
        } 
      }
   >>
>>