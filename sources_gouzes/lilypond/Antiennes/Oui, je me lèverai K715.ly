\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     a2^\< a4\! c a^\> d c2\! 
     f,4^\< g a2\! bes4^\> bes a2 g1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 66
          a2 a4 c a d c2\fermata\resp \tempo "Calme"
          f,4 g a2 bes4 bes a2 g1\fermata
          \bar"|."
        } \transpose b a \tonVIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f4 e f g a2 f4 e f2 d4 e f2 c1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Oui_! Je me lè -- ve -- rai, et j’i -- rai vers mon Pè -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 c d d e2 d4 d c2 bes4 bes c (d) e1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 a bes bes a2\fermata\resp bes4 bes f2 g4 g f2 c1\fermata
        } \transpose b a \tonVIbh
      }
   >>
>>