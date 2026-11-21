\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose d c
\new ChoirStaff
<< \new Dynamics 
   {
      d2 d4 (cis) d cis b2 b a1\resp
         fis2 b b1 b2 a b1\resp
         b2\< b d1\! cis2 b b\> (a) b1\!\resp
         b2\< b1 b2\! b1\> a2 b1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 60
         d2 d4 (cis) d cis b2 b a1\fermata\resp
         fis2 b b1 b2 a b1\fermata\resp
         b2 b d1 cis2 b b (a) b1\resp
         b2 b1 b2 b1 a2 b1\fermata
         \bar"|."
       } \transpose a b \tonIIIaf
       %\transpose a b \tonIIIif
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         fis2 fis4 (e) fis e d2 d4 (e) fis1
         d2 d e1 fis2 fis fis1
         e2 fis4 (g) fis1 e2 d cis1 dis
         dis!2 e1 e2 cis1 cis2 dis!1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     In -- cli -- ne les cieux, Sei -- gneur,
     et des -- cends par -- mi nous_!_
     Ma -- ni -- fes -- te ta gloi -- re
     à ceux qui crient vers toi_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a a4 a b2 b cis1 b2 b b1 cis2 cis dis1
          b2 b a1 a2 fis fis1 fis
          fis2 g1 g2 fis1 fis2 fis1
        } \transpose a b \tonIIIah
       %\transpose a b \tonIIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d2 d4 d g2 g fis1\fermata\resp
          b2 g g1 fis2 fis b,1\fermata\resp
          g'2 fis4 (e) d1 a2 b fis'1 b,\resp
          b2 e1 e2 fis1 fis2 b,1\fermata
        } 
      }
   >>
>>