\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme, bien balancé" 2 = 50
         c2 a4 d d2 d4 e c2 c4 d a2 a\resp
         a4 4 g2 4 4 bes a g2. 4\resp c2\fermata c\fermata a1\fermata
         \bar"|."
       } \tonVIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         a2 f4 f g2 4 4 a (g) f e f2 2 4 4 e2 4 4 g f e2. 4
         f2 e f1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Com -- me la pluie qui des -- cend sur la ter -- re,
     le Sei -- gneur a bé -- ni son peu -- ple dans la paix.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 4 d4 2 4 4 e2 d4 d c2 c c4 c c2 4 4 d d e2. 4
          c2 2 1
        } \tonVIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 bes4 2 4 4 a2 bes4 4 f2 f\resp
          f4 4 c2 4 4 g' g c2. 4\resp a2\fermata g\fermata f1\fermata
        } 
      }
   >>
>>