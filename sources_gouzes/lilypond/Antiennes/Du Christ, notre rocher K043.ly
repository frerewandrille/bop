\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 4 = 96
          g4 g-> fis g-> a bes2\resp 
          bes4-> bes a-> bes c2 bes4 (a) bes2 (a) g2.\resp 
          g4 g-> g g-> g a2. a4 g2 fis! g1\fermata
          \bar"|."
        } \tonIIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d d d f f2 f4 f f f f2 f f (d) d2. 
          d4 d d d d ees2. ees4 d2 d d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Du Christ, no -- tre ro -- cher, 
      ont cou -- lé des flots d’eau vi -- ve_: 
      Ve -- nez pui -- ser aux sour -- ces du sa -- lut_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 bes a bes c d2 d4 d c d ees2 d4 (c) d2 (c) bes2.
          bes4 bes bes bes bes c 2. c4 bes2 a bes1
        } \tonIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g-> d g-> f bes2\resp 
          bes4-> bes f-> bes a2 bes4 (f) f2 (fis) g2.\resp 
          g4 g-> g g-> g c,2. c4 d2 d <g, g'>1\fermata
        } 
      }
   >>
>>