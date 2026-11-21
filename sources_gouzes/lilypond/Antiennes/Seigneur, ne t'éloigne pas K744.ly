\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 48
          bes2 a2.\resp a8 [a] bes4 d d c c2\resp bes2 bes4 bes a2 a
          \bar"|."
        } \tonIVdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 fis2. fis8 [fis] g4 g g g a2 g g4 g f2 f
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, ne t’é -- loi -- gne pas de moi_: Viens à mon ai -- de_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d2. d8 [d] d4 d e e f!2 d e4 e f2 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 d2. \resp d8 [d] g4 bes bes bes a2\resp bes g4 g <d d'>2 q
        } \tonIVdh
      }
   >>
>>