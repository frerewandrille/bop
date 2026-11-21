\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo "Léger" 2. = 60
          a2 c4 c2 a4 a2. \breathe a4^> bes bes g2 g4 c2 c4 a2. \bar "|"
          d4^>  d d d2. \breathe d2 c4 bes2. c2 c4 a2.\fermata
          \bar "|."
        } \tonVIhf
      } 
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          f2 e4 e2 fis4 fis2. fis!4 g g e2 e4 a2 a4 fis!2.
          f!4 f f fis2. fis2 fis4 g2 (f!4) e2 e4 f2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Lè -- ve_- toi, Sei -- gneur, dans ta ten -- dres -- se pour Si -- on_! 
      L’heure est ve -- nue de nous prendre en pi -- tié_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4\cadenzaOn
          c2 c4 c2 d4 d2. d4 d d c2 c4 e2 e4 d2. d4 d d d2. d2 d4 d2. c2 c4 c2.
        } \tonVIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f2 a4 a2 d,4 d2. \breathe d4_> g g c,2 c4 a'2 a4 d,2. 
          bes'4_> bes bes a2.\breathe a2 a4 g2. g2 g4 f2.\fermata
        }
      }
   >>
>>