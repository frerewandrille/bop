\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 56
          c2 b4 (a) a2 a gis1\fermata\resp 
          e4 e f2 f4 f e e e a a2 gis!\fermata
          \bar"|."
        } \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 f e e e1 c4 c d (c) b d c b c d e2 e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ré -- ponds_- moi, Sei -- gneur_! 
      Que l’a -- bî -- me des eaux ne me sub -- mer -- ge_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 (b) c2 b4 (a) b1 
          a4 a a2 gis4 gis a gis a a8 ([b]) c4 (b8 [a]) b2
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a2 d e e e1\fermata\resp a4 g f (e) d d e e e f e2 e\fermata
        } 
      }
   >>
>>