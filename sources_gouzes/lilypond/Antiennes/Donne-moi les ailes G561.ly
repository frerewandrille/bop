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
         e4-> e gis-> a b2 b4-> cis b-> a b2 b2.\resp 
         b4 a-> cis4 d-> (cis) b-> cis b-> a b2 b\bar"|"
         cis b4 (a) gis2 (fis) \resp a4-> a gis fis e2\fermata
         \bar"|."
       } \tonVIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 e gis a b2 b4 cis b a b2 b2. b4 e,4 e d (e) fis e fis cis e2 e
         e e4 (cis) e (d cis2) b4 cis d cis b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Don -- ne_- moi les ai -- les de la co -- lom -- be, 
     que je m’en -- vo -- le vers ton Roy -- au -- me_!_
     Viens, Sei -- gneur, viens, Sei -- gneur Jé -- sus_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 e gis a b2 b4 cis b a b2 b2. b4 cis4 cis a2 a4 a a a gis2 gis
          a gis4 (fis) gis2 (a) fis4 fis b a gis2
        } \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> e gis-> a b2 b4-> cis b-> a b2 b2.\resp 
          b4 a4-> gis fis (e) d e d-> ->fis e2 e
          a, e'4 (fis) cis2 (fis4 e) \resp d-> cis b d e2\fermata
          
        } 
      }
   >>
>>