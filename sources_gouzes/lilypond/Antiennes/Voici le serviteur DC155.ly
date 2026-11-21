\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          g2 a2. a4 c c a c b2 b\fermata\allowBreak
          g g4 g a a g f g2\fermata\allowBreak g2 g4-> f e2\fermata
          \bar"|."
        } \tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e2. e4 e e f e g2 g c, c4 c f f e d d2 d2 e4 d b2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Voi -- ci le ser -- vi -- teur fi -- dè -- le 
      que le Sei -- gneur a é -- ta -- bli
      sur sa mai -- son.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 c2. c4 c c c c d2 d e e4 e c c c a b2 b c4 a gis2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 a2. a4 a a f a g2 g\fermata 
          c, c4 c f f c d <g, g'>2\fermata g' c,4-> d e2\fermata
        } \tonIVch
      }
   >>
>>