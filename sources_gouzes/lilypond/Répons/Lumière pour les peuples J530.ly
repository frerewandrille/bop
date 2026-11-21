\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "" 2 = 52
         a8 4 8 [8] f [g] a4. (bes8 c2) a4 \resp
         c d2 4 c4 2\resp 4 bes4. 8 c4 c a2\fermata
         \bar"|."
       } \tonVIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f8 4 8 [8] 8 [8] 1 4 4 2 4 e f2 4 d4. 8 e4 4 f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Lu -- miè -- re pour tous les peu -- ples,
ô Christ no -- tre Dieu,
et gloi -- re d’Is -- ra -- ël_!
   }
   \new Staff \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c8 4 8 [8] a [bes] a4. (bes8 a2) c4 a bes2 4 g a2
          4 g4. 8 4 4 f2
        } \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 4 8 [8] 8 [8] 1 4\resp 4 bes,2 4 c f2\resp
          4 g4. 8 c,4 4 f2\fermata
        } 
      }
   >>
>>