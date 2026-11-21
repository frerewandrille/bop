\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 72
         e4 g2 g4-> a a2 a\resp a4-> g a2. b4 g-> a a2\resp
         e4-> a fis-> g4 e-> d e1 \bar"|"
         e2 e4 d c2\resp c4-> d e2 g e\fermata
         \bar"|."
       } \tonIVaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 g2 g4 a a2 a e4 e e2. g4 e e e2 c4 d d b4 c b g (a b2)
         b2 c4 b a2 a4 b c2 b cis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Vi -- si -- te la ter -- re, bé -- nis_- la de ton a -- mour,
     toi l’es -- poir de tou -- te chair_!
     Viens nous sau -- ver_!_ Viens, Sei -- gneur Jé -- sus_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 g2 g4 a a2 a c4 d c2. d4 d d c2 a4 a b g4 a fis e (fis g2)
          g a4 fis e2 e4 fis a2 g a
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 g2 g4-> a a2 a \resp a4-> b a2. g4 b-> b a2\resp
          a4-> fis d e4 a,-> b c2 (b)
          b a4 b c2\resp c4-> b a2 e' <a, a'>\fermata
        } 
      }
   >>
>>