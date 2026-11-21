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
         f4 (bes2. a4) bes (g) a4 (g) f (g) g2.\fermata\resp
         g4-> f g2 a4 -> bes g-> a g-> (f) f2\resp
         g4-> d g2 (a4 bes c2 d4->) c d-> ees d2\resp
         d4-> c bes-> a g-> bes4 2 f2.\fermata\resp
         bes4 4-> g a-> g f-> f d2\resp
         f4-> g bes-> a f a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4~ (f2 e) d e! d d2. d4 d e!2 4 4 4 4 d2 d d4 d d2 (c4 d ees2 f4) g f g f2
         4 ees d d d c d2 c2. d4 d d c c d d d2
         d4 d d f d d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Em -- ma -- nu -- el, Roi qui por -- tes la Loi nou -- vel -- le, 
     Es -- pé -- ran -- ce des na -- tions
     et Sau -- veur de tous les peu -- ples, toi, no -- tre Dieu, ne tar -- de plus,
     Viens Sei -- gneur, viens nous sau -- ver_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 (d'2 c) bes c a bes2. 4 4 c2 c4 c c c a2 a
          bes4 c bes2 (a g4 a bes) 4 4 g8 ([a]) bes2
          4 g8 ([a]) bes4 4 4 c bes2 a2. bes4 4 4 g g a a bes2
          c4 c d d c c bes2
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 (bes,2 c) d c d g2.\fermata\resp 
          g4-> g c,2 4-> 4 4-> 4 d2 2\resp
          g4-> a g2 (f ees d4->) ees d-> c bes2\resp
          4-> c d-> d ees-> 4 d (ees) f2.\fermata\resp
          d4 4-> d ees-> 4 f-> f g2\resp
          a4-> a g-> f a f g2\fermata
        } 
      }
   >>
>>