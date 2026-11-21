\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }

%\transpose f d
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 69
         f4 (bes2.) a4 bes2 bes4 g a g4 f g g2.\fermata\resp
         g2-> a4-> g a-> bes4 g-> a g-> (f) f2\resp 
         g4-> g d-> d g2. \allowBreak g4 a4-> g a-> bes c2 (d4 c d ees) d2\resp
         d4-> c bes-> a g-> bes4 2 f\resp
         f4-> bes a2. \allowBreak bes4 bes-> g a-> g f-> f d2\resp
         f4-> g bes-> a f a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
     { \voiceTwo \relative c'
       { 
         f4~ f2 <e \balloonText #'(1.5 . -2)\markup { "" } > d2 d4 d
         e! e d d d2. 
         d2 d4 d e! e e4 e d2 d2
         d4 d d d d2. d4 c c c d ees2 (f4 g f g) f2
         f4 ees d d d c d2 c c4 f f2. f4 f d c c d d d2
         d4 d d f d d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Ra -- meau de la ti -- ge de Jes -- sé, 
     si -- gne dres -- sé pour tous les peu -- ples_;
     de -- vant toi, les rois se tien -- nent en si -- len -- ce, 
     et les peu -- ples se pros -- ter -- nent_!_
     Viens Sei -- gneur, li -- bè -- re_- nous, ne tar -- de plus,
     Viens Sei -- gneur, viens nous sau -- ver_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 (d'2) <c \balloonText #'(1.5 . 2)\markup { "" } > bes2 4 4 
          c c a a bes2. 
          bes2 4 4 c c c c4 a2 a2
          bes4 4 c c bes2. 4 a a a a g (a bes2. g8 [a]) bes2
          4 g8 ([a]) bes4 4 4 c bes2 a2 4 d c2. d4 d bes g g a a bes2
           c4 c d d c c bes2
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 (bes,2) c d2 4 4 c c d d g2.\fermata\resp
          g2-> g4-> g c,-> c4 c-> c d2 d2\resp 
          g4-> g a-> a g2. 4 f f f f ees2 (d4 ees d c) bes2\resp
          bes4-> c d-> d ees4-> 4 d 4(ees) f2\resp
          f4-> f f2. d4 d-> d ees4-> 4 f-> f g2\resp
          a4-> a g-> f a f g2\fermata
        } 
      }
   >>
>>