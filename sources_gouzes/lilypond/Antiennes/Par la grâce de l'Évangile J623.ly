\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 120
         d2 f4 a2 a4 bes a g a2 d,4\resp
         d'2 c4 bes2 bes4 c2 bes4 a2.\bar"|"
         a4 f g a (bes) a a(f) g a2 a4\resp
         f g a e2 f4 d2.
         \bar"|."
       } 
       \tonIbf
     }
     \new Voice = "alto" %\with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c'
       { 
         d2 d4 e2 e4 d d d e2 d4 f2 e4 d2 d4 e2 d4 d2.
         f4 d e f (g) f f (d) d cis2 cis4 d d cis! cis2 bes4 a2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Par la grâ -- ce de l’É -- van -- gi -- le,
     les paï -- ens comme Is -- ra -- ël
     sont hé -- ri -- tiers de la pro -- mes -- se,
     mem -- bres du Corps du Christ.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 a2 a4 g a bes c2 a4 bes2 g4 g2 g4 g2 g4 f2.
          a4 a a a2 a4 a2 g4 e2 e4 d d e a 
          \override BalloonText.annotation-balloon = ##f 
          <g \balloonText #'(2 . 2.5)\markup { "" } >2
          f2.
        } 
        \tonIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d4 c2 c4 bes bes bes a2 d4\resp
          bes2 c4 g2 g4 c2 g4 d'2.
          d4 d d d2 d4 d2 bes4 a2 a4\resp d bes a a c2 d2.
        } 
      }
   >>
>>