\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Paisible et joyeux" 2 = 76
         g4 a f g g g c d bes2 a4 f a (bes) g2\resp
         f4 g bes2 c4 d d (c) bes2 a4 (bes) g2\resp
         g4 f g g (a f d) d2 \allowBreak f4 g bes a f a g2\fermata
         \bar"|."
       } \tonIIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d d d d d f f f2 f4 f f2 d d4 d d2 f4 f g2 f f d
         d4 d d d1 d2 d4 d g d d f d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le ciel res -- plen -- dit d’u -- ne lu -- miè -- re nou -- vel -- le_:
     Ceux qui cher -- chent ta fa -- ce, Sei -- gneur,
     te ren -- dent grâ -- ce et s’a -- vancent en ta clar -- té.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 c a a bes bes a bes d2 c4 a c (d) bes2 
          c4 c bes2 a4 bes bes (c) d2 c4 (d) bes2
          bes4 a bes bes (c a2) bes c4 c d c a c bes2
        } \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g d d g g f f f2 f4 a f2 g\resp
          a4 a g2 f4 f ees2 d f g\resp
          g4 d d d2 (f) g a4 a g g a f g2\fermata
        } 
      }
   >>
>>