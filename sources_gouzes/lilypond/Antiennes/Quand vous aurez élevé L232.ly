\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 54
          a2 b4 c a2 b4 c d d c b a2 gis2.\fermata\resp
          e4 e2 e4 e a2 a g a1\fermata
          \bar"|."
        } \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e4 e d2 d4 e f f e e e2 e2. e4 e2 e4 e c (d) e2 e e1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Quand vous au -- rez é -- le -- vé le Fils de l’hom -- me,
      a -- lors vous sau -- rez que Je Suis_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 b4 b a2 a4 a a a a b c (b8 [a]) b2.
          c4 c2 c4 b a2 b b c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 g4 g f2 f4 e d d e e e2 e2.\fermata\resp
          a4 a2 a4 g f2 e e a,1\fermata 
        } \tonIVah
      }
   >>
>>