\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "Vif" 2 = 69
         g2 a b c4 a b2 g4 fis g a a2\bar"|"
         g4 g fis g a a b a g2 g4 e fis2 fis \bar"|"
         b2 c4 (a) b2 g4 fis g a a2 \bar"|"
         g4 g fis g a a b a g2 g4 e fis2 \bar"|"
         b2 c4 (a) b2 g4 fis g a a2 
         \fermata \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e2 fis g g4 g g2 e4 e e fis fis2
         e4 e e e e e e e e2 e4 e d2 d g g g e4 e e fis fis2
         e4 e e e e e e e e2 e4 e d2 g g g e4 e e fis fis2
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
          b2 d d e4 c d2 b4 a b d d2
          b4 b a b c c d c b2 b4 g a2 a d e4 (c) d2 b4 a b d d2
          b4 b a b c c d c b2 b4 g a2 d e4 (c) d2 b4 a b d d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 d g g4 g g2 e4 e e d d2
          e4 e e e a, a a a e'2 e4 e d2 d g g g e4 e e d d2
          e4 e e e a, a a a e'2 e4 e d2 g g g e4 e e d d2
          \fermata
        } 
      }
   >>
>>