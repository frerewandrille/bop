\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo  2. = 50
          \partial4 g4 g-> g g-> g bes-> g f2 bes4-> c d2.\fermata\resp
          d4 d-> d d-> d f-> d c2 bes4-> c d2 \bar "|"
          bes4-> bes d2 c4-> d bes2 a4-> a g2\fermata\resp
          bes4-> bes g2 f4-> g bes-> c bes2 \bar "|"
          bes2c4-> (d) d2 (c4 bes a2\fermata)\resp
          bes4-> a g2^\markup\italic"rall." g \noBreak g\fermata 
          \bar "|."
        } \transpose a d' \tonIbf
        %\transpose g bes \tonIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 d4 d d d ees f ees c2 f4 f f2.
          f4 f f f f f f a2 g4 a bes2
          f4 f bes2 a4 a g2 f4 f d2 f4 f ees2 c4 ees f f d2
          f a bes (a4 g fis2) g4 ees d2 ees d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     La foule im -- men -- se des en -- fants des Hé -- breux 
     por -- taient des bran -- ches d’o -- li -- vier dans leurs mains.
     Ils cour -- raient au de -- vant du Sei -- gneur
     en chan -- tant et en pro -- cla -- mant_:
     Ho -- san -- na au plus haut des cieux_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \partial4 bes4 bes bes bes bes bes bes a2 bes4 a bes2.
          d4 d d d d c d f2 d4 f f2
          d4 d f2 f4 f ees2 c4 c bes2 bes4 bes bes2 a4 bes bes a bes2
          d2 f f2. (d) d4 c bes2 c b
        }\cadenzaOn \transpose a d' \tonIbh
        %\transpose g bes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial4 g4 g-> g f-> ees d-> ees f (ees) d-> f bes,2.\fermata\resp
          bes'4 bes-> bes bes-> bes a-> bes f2 g4-> f <bes, bes'>2
          bes'4-> bes bes2 f4-> d ees2 f4-> f g2\fermata\resp
          d4-> d ees2 f4-> ees d-> f bes2
          bes f4-> (d) bes2 (f'4 g d'2\fermata)\resp g,4-> c, d2 c g'2\fermata
        }
      }
   >>
>>