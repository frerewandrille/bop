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
         f4 (bes2. a4) bes (g a g4) f (g) g2.\fermata\resp
         g4 g-> g f-> g a-> (g) a-> bes g-> (f) f2\resp
         g4-> d g2 a4 bes c2 (d4 c d ees) d2\resp
         d4-> c bes-> a g2 a4-> bes4 2 f2.\allowBreak
         bes4 bes-> a g-> a a-> g f-> g g-> f d2\resp
         f4-> g bes-> a f a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4~ (f2 e) d (e) d d2. 
         d4 d d d d e2 e4 e d2 d d4 d d2 c4 d ees2 (f4 g f g) f2
         f4 ees d d d2 c4 c d2 c2. f4 f f d c c c d d d d d2
         d4 d d f d d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô O -- ri -- ent, splen -- deur de la Lu -- mière é -- ter -- nel -- le
     et So -- leil de jus -- ti -- ce,
     viens il -- lu -- mi -- ner les té -- nè -- bres 
     de ceux qui sont as -- sis à l’om -- bre de la mort,
     Viens Sei -- gneur, viens nous sau -- ver_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 (d'2 c) bes (c) a bes2. 4 4 4 c bes c2 c4 c a2 a
          bes4 c bes2 a4 a g (a bes2. g8 [a]) bes2
          4 g8 ([a]) bes4 4 2 c4 c bes2 a2. d4 d d bes c c c a a bes4 4 c2
          c4 c d d c c bes2
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 (bes,2 c) d (c) d g2.\fermata\resp
          g4 g-> g a-> g c,2 c4 c d2 d\resp
          g4-> a g2 f4 f ees2 (d4 ees d c) bes2\resp
          bes4-> c d-> d ees2 ees4-> 4 d (ees) f2. 
          d4 d-> d ees-> 4 ees-> 4 f-> f g-> g a2\resp
          a4-> a g-> f a f g2\fermata
        } 
      }
   >>
>>