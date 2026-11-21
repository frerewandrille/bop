\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2. = 40
         e2 4 a2 4 2 g4 a2. 2\resp e4 f2 4 e2 4 2.\fermata
         \bar"|."
       } \tonIVaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e2 4 d2 4 e2 4 2. 2 cis4 d2 4 b2 4 cis!2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur m'a fait re -- vi -- vre quand j'al -- lais à la mort.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 b4 a2 4 b2 4 cis2. 2 a4 2 4 2 gis4 a2.
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 g4 f2 4 e2 4 a2. 2\resp 4 d,2 4 e2 4 a,2.\fermata
        } 
      }
   >>
>>