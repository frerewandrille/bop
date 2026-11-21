\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     d2 c4 (bes) c2 d bes1 bes2 a4^\> g g2 (fis\!)\resp
     fis!2^\< fis4 fis g2 a^\> fis!\! \allowBreak
     fis^\< g4 a bes2^\> bes a a g1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 50
          d2^\p c4 (bes) c2 d bes1 bes2 a4 g g2 (fis\fermata)\resp
          fis!2 fis4 fis g2 a fis! \allowBreak
          fis g4 a bes2 bes a a g1\fermata
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 ees f4 (ees) d2 ees1 ees4 (d) c c d1
          d2 d4 c bes (c) d2 d d d4 c bes (c) d2 ees d4 (c) bes1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     De -- vant toi, Sei -- gneur, s’in -- cli -- ne -- ront 
     ceux qui sont des -- cen -- dus 
     dans la pous -- siè -- re de la mort.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 bes a a g1 g2 g4 g a1 a2 a4 a g2 fis4 (g) a2 
          a g4 fis! g2 g g fis! g1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g f f ees1 ees2 ees4 ees d1\fermata\resp 
          d2 d4 d ees2 d d c bes4 a g (a) bes2 c d g,1\fermata
        } \tonIIah
      }
   >>
>>