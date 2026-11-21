\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))


\new ChoirStaff
<< \new Dynamics 
   {
         f\breve*1/8 2 \breve*1/8\< g4\! 4 f2\> e f\!\bar"|"
         a\breve*1/8 2  \breve*1/8 bes4 4\rall\> a2 g a\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Marqué, vif" 2 = 84
         f\breve*1/8 2\resp \breve*1/8^\markup\italic"accelerando" g4 4 f2 e f\fermata\bar"|"
         a\breve*1/8 2 \resp \breve*1/8 bes4-> 4 a2 g a\fermata
         \bar"|."
       } \tonVIcf %pas de ton dans l’orig.
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c\breve*1/8 2 \breve*1/8 4 4 2 2 2 
         f\breve*1/8 2 \breve*1/8 e4 e f2 e f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Aujour -- \apostrophe d’hui, "le Seigneur brise les" por -- tes de la mort,
     aujour -- \apostrophe d’hui, "il détruit les puis" -- san -- ces des en -- fers_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a\breve*1/8 2 \breve*1/8 bes4 4 a2 g a
          c\breve*1/8 2 \breve*1/8 4 4 2 2 2          
        } \tonVIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/8 2 \resp \breve*1/8 e4 e f2 c f\fermata
          f\breve*1/8 2 \resp \breve*1/8 g4-> g f2 c f\fermata
        } 
      }
   >>
>>