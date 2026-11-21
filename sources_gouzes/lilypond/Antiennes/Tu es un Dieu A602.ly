\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 108
         a1 a2 fis e a b cis a1 a2\resp e a b cis d cis b4 (a) b2 a1\bar"|"
         b2 cis d e\resp cis b4 (a) b2 a1\fermata
         \bar"|."
       } \tonVIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         cis1 cis2 b cis cis e e fis1 fis2 cis fis fis e fis e e4 (cis) e2 e1
         e2 a fis e e fis gis e1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto "soprano"
   {
     Tu es un Dieu de dé -- li -- vran -- ce
     qui bri -- se les por -- tes de la mort_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e1 e2 fis gis a gis a a1 a2 a cis fis, gis b a gis4 (a) gis2 a4 (b cis2)
          b fis' d b cis d4 (cis) e2 cis1
        } \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a1 a2 d cis fis e a, d1 d2\resp a' fis d cis b cis4 (d) e (fis) e2 a,1
          gis'2 fis b gis\resp a d,4 (fis) e2 a,1\fermata
        } 
      }
   >>
>>