\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2. = 52
          g4\pp^\< g bes-> c bes bes-> (g2)^\> bes4\rest 
          g g bes->^\< g bes^\> g2.\! \bar"|"
          \time 2/2 \tempo "Très large" 2 = 60
          g4-> g a1 a2\fermata g\fermata g1\fermata
          \bar"|."
        } \transpose b g \tonVIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g g g g2. s4 g g g g g g2. g4 g g1 g2 f e1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le gar -- dien d’Is -- ra -- ël ne s’est pas en -- dor -- mi 
      dans la nuit du tom -- beau.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 g d' e d d (e2) s4 e e d e d e2. e4 e e1 e2 c c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g g-> c g g-> (c2) d,4\rest c' c g-> c g c2.
          c4-> c c1 c,2\fermata d\fermata c1\fermata
        } \transpose b g \tonVIIch
      }
   >>
>>