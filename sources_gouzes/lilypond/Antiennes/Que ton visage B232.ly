\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 4 = 80
          bes8 [g bes] bes4. (c16 [bes] a8 [g] bes [g]) g4\fermata\resp
          c8 [g] d'4 (c8 [d bes]) c [d] d2\fermata
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g8 [g g] g1 g4 g8 [g] bes4 (g4.) g8 [g] bes2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Que ton vi -- sa -- ge s’il -- lu -- mi -- ne pour nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [bes d] d2 (e?4 f) e e8 [e] f4 (e4.) e8 [e] f2
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [g g] g2 (c4 d) c4\fermata\resp
          c8 [c] bes4 (c4.) c8 [c] bes2\fermata
        } 
      }
   >>
>>