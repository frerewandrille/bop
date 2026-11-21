\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 63
         e4 gis-> a b-> cis b2\resp a4-> cis d-> cis b-> a b2\bar"|"
         cis b4 (a) gis2 (fis) \resp a4-> a gis fis e2\fermata
         \bar"|."
       } \tonVIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 gis a b cis b2 e,4 e d e fis cis e2
         e e4 (cis) e (d cis2) b4 cis d cis b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Mon Dieu, pour -- quoi tar -- der_?_ Sau -- ve_- nous par ton a -- mour_!_
     Viens, Sei -- gneur, viens, Sei -- gneur Jé -- sus_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 gis a b cis b2 cis4 cis a a a a gis2
          a gis4 (fis) gis2 (a) fis4 fis b a gis2
        } \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 gis-> a b-> cis b2\resp a4-> gis fis-> e d ->fis e2
          a, e'4 (fis) cis2 (fis4 e) \resp d-> cis b d e2\fermata
          
        } 
      }
   >>
>>