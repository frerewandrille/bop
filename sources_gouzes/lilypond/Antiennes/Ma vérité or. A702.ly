\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics { 
  \override Hairpin.to-barline = ##f
  bes1 f g bes d2 c bes bes~ bes a bes1 bes2\resp
  d c bes a f g2. a4 bes1 c2 bes a1 g
  g^\< f2 bes bes a bes1\!
  f^\< g2 g a a bes1\! d^\> c2 (bes) a1 g\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo  2 = 84
          bes1 f g bes d2 c bes bes~ bes a bes1 bes2\resp
          d c bes a f g2. a4 bes1\breathe c2 bes a1 g\fermata
          g f2 bes bes a bes1\breathe
          f g2 g a a bes1\breathe d c2 (bes) a1 \noBreak g\fermata
          \bar "|."
        }\cadenzaOn \transpose g bes \tonIIif
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d1 d ees f f2 ees ees f (g) f f1 f2 f f d f d ees ees f1
          f2 d d1 d g,4 (a bes c) d2 f f f f1
          d ees2 ees c c d2. (ees4) f1 f2 (d) d1 d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Ma vé -- ri -- té et ma mi -- sé -- ri -- cor -- de 
     à tout ja -- mais sont a -- vec toi. Al -- lé -- lu -- ia.
     J’é -- xal -- te -- rai ton Nom au des -- sus de tout nom. 
     Al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          g1 d2 (bes') bes2. (c4) d1 d2 g, g d' (c) c d1 d2
          bes a bes d a c c d1 a2 g g (fis) g1
          bes2. (a8 [g]) a2 d c c d1 bes bes2 bes a a f1
          bes a2 (g) g (fis) g1
        }\cadenzaOn \transpose g bes \tonIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          g1 bes ees bes bes2 c c d (ees) f bes,1 bes2\breathe
          bes f' g d d c c bes1\breathe f'2 g d1 g,\fermata
          ees' d2 bes f' f, bes1\fermata
          bes ees2 (d4 ees) f2 f, bes1\breathe bes f2 (g) d'1 g,\fermata
        }
      }
   >>
>>