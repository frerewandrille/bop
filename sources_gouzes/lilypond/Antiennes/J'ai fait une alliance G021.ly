\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 66
          g4 bes-> bes a-> a g2 g4 \resp
          g a-> a f f g2.\resp
          \tempo "Plus vif"
          g4 d'-> d e? e d8 ([c]) bes4 bes2 c bes1\fermata          
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 s s s s s s s
          g4 f f d d d2. g4 g g g g g g g2 a g1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      J’ai fait une al -- li -- an -- ce a -- vec mon ser -- vi -- teur_:
      J’é -- ta -- bli -- rai son trô -- ne à ja -- mais_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 d'_> d e?_> c d2 bes4 bes c_> c c c bes2.
          bes4 bes bes c c bes8 ([c]) d4 d (e) c (d) d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 s s s s s s s \resp
          g4 f f a a g2.\resp g4 g-> g c, c g' g g2 f g1\fermata
        } \tonIIah
      }
   >>
>>