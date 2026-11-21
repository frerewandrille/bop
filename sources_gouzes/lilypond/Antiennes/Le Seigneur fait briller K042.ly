\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 63
          bes4 bes a-> bes c bes-> \allowBreak
          g a bes2 bes4 a2 g4 a2. (g2 f!4) g2\fermata\resp 
          g4^\markup{\italic"rall. sub."} g2 g4 g2 f!4 g2.
          \bar"|."
        } \transpose a g \tonIIIgf %Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g g g g g g g2 g4 d2 d4 ees2. (d) d2 d4 c2 c4 d2 d4 d2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le Sei -- gneur fait bril -- ler la lu -- miè -- re de sa fa -- ce_: 
      Ve -- nez, a -- do -- rons_- le_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d c d ees d bes c d2 d4 c2 bes4 c2. (bes4 a2) bes2
          bes4 g2 g4 a2 a4 bes2.
        } \transpose a g \tonIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g g-> g g g-> g g g2 g4 g2 g4 c,2. (d) g2\fermata\resp 
          g4 ees2 ees4 d2 d4 <g, g'>2.
        } 
      }
   >>
>>