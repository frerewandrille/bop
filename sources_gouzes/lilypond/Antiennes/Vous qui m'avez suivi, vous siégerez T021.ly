\version "2.24.0"
%\include "TonsDef.ly"

\transpose a g
\new ChoirStaff  
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \cadenzaOn 
          \tempo "Large"  2 = 56
          a2 a4 a c2 d e2. \fermata \breathe\allowBreak
          e4 e-> e e2. e4 e-> e e2 (d4 c) d2. \breathe\allowBreak
          d4 d-> d e2 e4 e a,2 a g a1\fermata\bar"||"
        } \tonIIIaf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          e2 e4 e f2 a gis2. g4 g g g2. g4 g g a2 (f) g2.
          g4 g g g2 g4 g f2 d e e1
        }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano" 
     Vous2 qui4 m’a -- vez2 sui -- vi,2. vous4 sié -- ge -- rez2.
     sur4 dou -- ze trô1 -- nes2.
     ju4 -- geant les dou2 -- ze4 tri -- bus2 d’Is -- ra -- ël.1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \cadenzaOn 
          c2 c4 c a2 a b2. c4 c c c2. c4 c c c1 b2.
          b4 b b c2 c4 c c2 a b cis1
        }\tonIIIah
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          a2 a4 g f2 f e2.\fermata \breathe
          c4 c-> c c2. c4 c-> c f2 (a) g2. \breathe
          g4 g-> g c,2 c4 c f2 f e a,1\fermata
        }
      }
   >>
>>