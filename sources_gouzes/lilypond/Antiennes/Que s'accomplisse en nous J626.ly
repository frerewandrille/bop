\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 4 = 112
         c4-> c c b2 g4 a2 a4 e2 e4 g-> g a g2.\resp
         g2-> g4 a-> a c b-> b g a2 g4 e2. e2\fermata\resp
         e4 e-> e e g2 f4 e2 e4 e2 e4 d2 d4 e2.\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto" %\with { \consists "Balloon_engraver" }
      %\override BalloonText.annotation-balloon = ##f 
      %<fis \balloonText #'(2 . -2)\markup { "" } >
      { \voiceTwo \relative c''
       { 
         g4 g g g2 d4 f2 f4 c2 c4 e e e e2.
         e2 e4 e e e g g e c (d) e e2. e2
         e4 e e e e2 c4 c2 c4 c2 c4 a2 b4 c2.
       } \transpose a g \tonVIIjf
       %\tonIVef
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que s’ac -- com -- plisse en nous l’a -- vé -- ne -- ment du Sei -- gneur,
     ce mys -- tè -- re ca -- ché a -- vant tous les siè -- cles
     et qui s’est ma -- ni -- fes -- té à ceux qui croient en lui.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e4 e e d2 b4 c2 c4 a2 a4 b b c b2.
          b2 b4 c c c e e b a2 b4 c2. c2
          c4 c c c b2 a4 g2 g4 a2 a4 f2 f4 g2.
        } \transpose a g \tonVIIjh
        %\tonIVeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c4-> c c g'2 g4 f2 f4 a2 a4 e-> e a, e'2.\resp
          e2-> e4 c-> c a e'-> e e f2 e4 a2. a2\fermata\resp
          a4 a-> a a e2 f4 c2 c4 a2 a4 d2 d4 c2.\fermata
        } 
      }
   >>
>>