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
         f4 (bes2. a4 bes g) a2 g4 f g2.\fermata\resp
         g4 g2 a4-> g a-> bes g-> (a) g-> f f2\resp
         g4-> d g2. \allowBreak g4 g-> a g2 (a4 bes c2 d4 c d ees) d2.\resp
         d4 c2-> bes4-> a g-> a bes-> bes f2\resp
         f4-> bes a2. \allowBreak bes4 bes-> a g-> a a-> g f-> g g-> f d2 d\resp
         f4-> g bes-> a f a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4~ (f2 e d) e d4 d d2. d4 d2 d4 d e! e e2 d4 d d2
         d4 d d2. d4 d d d1 (ees2 f4 g f g) f2.
         f4 ees2 d4 d d c d d c2 c4 f f2. f4 f f d c c c d d d d d2 d
         d4 d d f d d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Clef de Da -- vid et scep -- tre de la mai -- son d’Is -- ra -- ël,
     toi qui ouvres et nul ne fer -- me,
     tu fermes et per -- son -- ne n’ou -- vri -- ra_!_
     Viens Sei -- gneur pour dé -- li -- vrer 
     ceux qui ha -- bi -- tent les té -- nè -- bres,
     Viens Sei -- gneur, viens nous sau -- ver_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 (d'2 c bes) c a4 a bes2. 4 2 4 4 c c c2 a4 a a2
          bes4 c bes2. 4 4 c bes2 (a g4 a bes2. g8 [a]) bes2.
          4 g (a) bes4 4 4 c bes4 4 a2
          a4 d c2. d4 d d bes c c c a a bes bes c2 c
           c4 c d d c c bes2
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 (bes,2 c d) c d4 d g2.\fermata\resp
          g4 g2 g4-> g c,-> c c2 d4-> d d2\resp
          g4-> a g2. g4 g-> g g2 (f ees d4 ees d c) bes2.\resp
          4 c2 d4-> d ees4-> 4 d-> ees f2\resp
          f4-> f f2. d4 d-> d ees-> 4 ees-> 4 f-> f g-> g a2 a\resp
          a4-> a g-> f a f g2\fermata
        } 
      }
   >>
>>