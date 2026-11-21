\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose gis fis
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 84
         gis4 gis a b cis b2 \allowBreak 
         b4 b cis a b a gis2\bar "|"
         a4^\markup{ \dynamic p \italic "sub." } b cis b a gis2 \allowBreak
         e4^\markup\italic"élargir" fis a fis gis fis e2 e
         \bar"|."
       } \transpose a b \tonVIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e fis gis a gis2 e4 e e fis d d e2
         e\breve*1/8 s s s s e2 b4 d d cis e d b2 b
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ils vien -- nent d’O -- ri -- ent, 
     ap -- por -- tant l’or et l’en -- cens.
     En toi se -- ront bé -- nis tous les peu -- ples 
     de la ter -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b a gis fis e2 gis4 gis a a fis a b2
          cis4 d e d cis b2 gis4 a a b b a gis2 gis
        }  \transpose a b \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 e e e e e2 e4 e a, d d fis e2
          e\breve*1/8 s s s s e2 e4 e fis fis e e e2 e
        } 
      }
   >>
>>