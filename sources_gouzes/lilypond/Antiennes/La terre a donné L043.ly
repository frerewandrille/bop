\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          g4 g2-> g4 bes g2-> f bes4 c d2\fermata\resp 
          d4 d d2-> d4 f d2 (c) bes4 c d2\fermata \bar"|"
          bes4 d c d bes a g2.\fermata\resp
          bes4 bes2 g f4 g bes (c) bes2\fermata\bar"|"
          bes2 c4 (d) d2 (c4 bes a2\fermata)\resp bes4 a g2 g g\fermata
          \bar"|."
        } \transpose g c' \tonIbf
        %\transpose g bes \tonIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d2 ees4 f ees2 c f4 f f2 f4 f f2 f4 f f2 (a) g4 a bes2
          f4 bes a a g f d2. f4 f2 ees c4 ees f (a) f2
          f2 a bes (a4 g fis2) g4 ees d2 ees d
        }    
      }
   >>
   \new Lyrics \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La terre a don -- né son plus beau fruit_: 
     de sa croix, le Sei -- gneur nous bé -- nit_!
     Et les peu -- ples ras -- sem -- blés 
     ac -- cla -- ment son tri -- om -- phe_:
     Ho -- san -- nah au plus haut des cieux_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 bes2 bes4 bes bes2 a bes4 a bes2 d4 d d2 d4 c d2 (f) d4 f f2
          d4 f f f ees c bes2. bes4 bes2 bes a4 bes d (c) d2
          d f f2. (d) d4 c bes2 c b
        } \transpose g c' \tonIbh
        %\transpose g bes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g-> (f) ees d ees2-> f4 (ees) d f bes,2\fermata\resp
          bes'4 bes bes2-> bes4 a bes2 (f) g4 f <bes, bes'>2\fermata 
          bes'4 bes f d ees f g2.\fermata\resp 
          d4 d2 ees f4 ees d (f) bes2\fermata
          bes f4 (d) bes2 (f'4 g d'2)\fermata\resp 
          g,4 c, d2 c <g g'>\fermata
        } 
      }
   >>
>>