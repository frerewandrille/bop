\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 3/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 1. = 40
          d2 d1 c2 b1 b2 a1 a2 gis1.\resp 
          gis!2 gis gis a1 a2 g1\allowBreak g2 f1 f2 e1. e\bar"|"
          gis1 gis2 a1 a2 b (g) a a1 gis2 a1.
          \bar"|."
        } \tonIIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 fis1 e2 g1 g2 f (e) d e1. e2 e e e1 e2 e1 e2 c1 d2 b1. b
          e1 e2 e1 f2 g (e) e e1 e2 e1.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Bé -- ni sois_- tu, Sei -- gneur Jé -- sus, toi qui as fait
      de Pierre un pê -- cheur d’hom -- mes,
      et de Paul, l’A -- pô -- tre des na -- tions.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 a1 a2 g1 g2 c1 a2 b1. b2 b b c1 c2 b1 b2 a1 a2 gis1. gis
          b1 b2 cis1 d2 d (c) c b1 b2 cis1.
        } \tonIIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 d1 a2 e'1 e2 f1 f2 e1.\resp
          e2 e e a1 a2 e1 e2 f1 d2 e1. e
          e1 e2 a1 d,2 g (c) a e1 e2 a1.
        } 
      }
   >>
>>