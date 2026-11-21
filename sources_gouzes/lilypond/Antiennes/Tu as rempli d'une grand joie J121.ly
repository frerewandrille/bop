\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
         f4 f e d2 e4 f g a g2 a f4 g f (e) e2
         f4 e d2 (e4) f g a g2
         g\< g4\! a\> f g f e e2\!
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2 = 66
         f4 f e d2 e4 f g a g2\resp a f4 g f (e) e2\resp
         f4 e d2 (e4) f g a g2\resp
         g g4-> a f->
         g f\fermata e\fermata e2^\markup\italic\right-align"élargir dans l’adoration"\fermata
         \bar"|."
       } \tonIVaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d d d2 d4 d e d e2 d d4 e d2 e
         d4 d d2~ d4 d e e e2 e e4 d d e d d e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu as rem -- pli d’u -- ne gran -- de joie
     tou -- te la ter -- re_:
     El -- le chan -- te pour ton Nom
     et se pros -- ter -- ne de -- vant toi.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a b c2 c4 c b c b2 c c4 b c (b) cis2
          a4 a a2. a4 c c c2 c c4 c c b c b c2
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d g a2 a4 a g f g2\resp f a4 g a2 a\resp
          a4 g f2 (e4) d c c c2\resp
          c c4-> f a-> g a\fermata a\fermata a2\fermata
        } 
      }
   >>
>>