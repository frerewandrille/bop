\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très large"% 2 = 52
         a2 e g e1\fermata\resp
         a2 e g e1\fermata\resp
         e4 e f2 e e1\fermata
         \bar"|."
       } \tonIVmf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e2 e e cis1  e2 e e cis!1 cis!4 cis d2 b cis!1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Saint Dieu, saint fort, saint im -- mor -- tel,
     prends pi -- tié de nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 a b a1 c2 a b a1 a4 a a2 gis a1
        } \tonIVmh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a2 c e a1\fermata\resp a,2 c e a1\fermata\resp
          a,4 a d2 e a,1\fermata
        } 
      }
   >>
>>