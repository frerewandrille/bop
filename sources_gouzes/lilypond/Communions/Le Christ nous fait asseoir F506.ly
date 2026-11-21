\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         g2 4 4 fis e a2. 2 b4 g2 4 \resp
         2 4 4 fis e a2. \allowBreak 4 b c b2. a g
         \bar"|."
       } \transpose a g \tonVIIdf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d2 4 4 4 4 e2. fis2 4 d2 4 2 4 4 4 4 e2. fis4 g g g2. fis4 (e fis) d2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Christ nous fait as -- seoir à sa ta -- ble_! “Le Ro -- yau -- me de Dieu est au mi -- lieu de vous.”
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 4 4 a g c2. 2 d4 b2 4 2 4 4 a g c2. 4 d e d2. c b
        } \transpose a g \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 4 4 d d d2. 2 4 g2 4\resp
          g2 4 4 d d d2. 4 g g g2. d g
        } 
      }
   >>
>>