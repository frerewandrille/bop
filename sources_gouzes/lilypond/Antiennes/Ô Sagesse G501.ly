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
         f4 (bes2.) a4 bes2 (a4 g a2 g4 f) g2.\fermata\resp
         g4 g2 a4 g a2 (bes4) g a g f2.\resp g4 d-> g g2 (a4 bes c2 d4) c d ees d2.\resp
         d4 d-> c bes-> a bes-> c c2. c4 \allowBreak g-> bes bes-> g a-> g f2 f\resp
         f4-> bes a2. \allowBreak bes4 bes-> g a-> g f-> g g-> f d2\resp
         f4-> g bes-> a f a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
     { \voiceTwo \relative c'
       { 
         f4~ f2 <e \balloonText #'(1.5 . -2)\markup { "" } > d1 (e!2 d) d2. d4 d2 d4 d e!2. e4 e e d2.
         d4 d d d2 (c4 d ees2 f4) g f g f2. 
         f4 f ees d d f f g2. g4 ees 4 f d c c c c2 c
         c4 f f2. f4 f d c c d d d d d2
         d4 d d f d d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Sa -- ges -- se sor -- tie de la bou -- che du Très_- Haut,
     toi qui em -- bras -- se l’u -- ni -- vers
     et qui dis -- po -- ses tou -- tes cho -- ses dans la force et la ten -- dres -- se,
     Viens Sei -- gneur nous en -- sei -- gner les che -- mins du sa -- lut,
     Viens Sei -- gneur, viens nous sau -- ver_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 (d'2) <c \balloonText #'(1.5 . 2)\markup { "" } > bes1 (c2 a) bes2. bes4 bes2 4 4 c2. c4 c c a2.
          bes4 c c bes2 (a g4 a bes) 4 4 g8 ([a]) bes2.
           4 4 g8 ([a]) bes4 c d d ees2. 4 c c bes4 4 4 4 a2 a
           a4 d c2. d4 d bes g g a a a a bes2
           c4 c d d c c bes2
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 (bes,2) c d1 (c2 d) g2.\fermata\resp
          g4 g2 g4 g c,2. c4 c c d2.\resp g4 a-> a g2 (f ees d4) ees d c bes2.
          4 bes-> c d-> d d-> d c2. c4 c-> c d-> d ees-> 4 f2 f\resp
          f4-> f f2. d4 d-> d ees-> 4 f-> f f-> f g2\resp
          a4-> a g-> f a f g2\fermata
        } 
      }
   >>
>>