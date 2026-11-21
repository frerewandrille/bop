\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "" 2 = 52
         
         \bar"|."
       } 
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          
        } 
      }
   >>
>>