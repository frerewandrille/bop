\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 63
         e4 gis-> a b-> cis b2\resp 
         b4-> b a2 cis4-> d cis-> b b-> a b2\bar"|"
         cis b4 (a) gis2 (fis)\resp a4-> a gis fis e2\fermata
         \bar"|."
       } \tonVIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 gis a b cis b2 b4 b e,2 e4 d e fis fis cis e2
         e e4 (cis) e (d cis2) b4 cis d cis b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     J’es -- pè -- re le Sei -- gneur_: Il a mis sur mes lèvres un chant nou -- veau_:_
     Viens, Sei -- gneur, viens, Sei -- gneur Jé -- sus_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 gis a b cis b2 b4 b cis2 cis4 a a a a a gis2
          a gis4 (fis) gis2 (a) fis4 fis b a gis2
        } \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 gis-> a b-> cis b2\resp 
          b4-> b a2  gis4-> fis e-> d d-> fis e2
          a, e'4 (fis) cis2 (fis4 e)\resp d-> cis b d e2\fermata
        } 
      }
   >>
>>