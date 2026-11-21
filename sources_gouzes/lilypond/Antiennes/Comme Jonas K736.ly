\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 60
          a2 a4 a g2 g4 g f2 e4 d e2 e2.\fermata\resp
          e4 e-> e a b c2 c4 c b2 \allowBreak b4 b a2 a4 a a2 (gis) a1\fermata
          \bar"|."
        } \tonIVbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e4 e e2 e4 e e (d) c c b2 b2. 
          e4 e e e g g2 g4 g e2 e4 e e2 c4 d e1 e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Com -- me Jo -- nas dans le ven -- tre du mons -- tre, 
      ain -- si le Fils de l’hom -- me
      se -- ra dans le sein de la ter -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 c b2 b4 b a2 a4 a gis2 gis2.
          e4 e e c' d e2 e4 c d2 d4 d c2 c4 c b1 c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 a e2 e4 e f2 fis4 fis e2 e2.\fermata\resp
          e4 e-> e a g c,2 c4 e gis2 gis4 gis a2 a4 a e1 a\fermata
        } \tonIVbh
      }
   >>
>>