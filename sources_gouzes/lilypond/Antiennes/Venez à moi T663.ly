\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Lent" 2 = 56
         a2 a4 c a2 a a4 g a2 f4 g a2 a g4 f g2\fermata\bar"|"
         f2 f4 f e f d2 e4 c d2.\resp
         d4 f-> g a2 g f4 (e8 [d]) e4 c d2\fermata
         \bar"|."
       } \tonIhf
     }
     \new Voice = "alto" %\with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c'
       { 
         f2 f4 g f (e) d (e) f e d (e) \allowBreak 
         f e f (e) d (e) f d e2
         d2 d4 d c c bes2 bes4 a8 ([g]) f2. 
         bes4 d d e2 d4 (e) d2 c4 a a2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Ve -- nez à moi, 
     vous qui pei -- nez et plo -- yez sous le far -- deau,
     et je vous don -- ne -- rai le re -- pos, 
     car je suis doux et hum -- ble de cœur.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 c4 c d2 bes a4 c a2 a4 a d (c) bes (c) d a c2
          a bes4 a a a f2 g4 e d2. 
          f4 bes bes c2 bes a4 (g8 [f]) g4 g f2
        } \tonIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 (e) f e d (c) bes (c) d e f (e) 
          d c bes (c) d (c) bes d c2\fermata
          d4 (c) bes d a a bes (a) g a bes2. \resp bes4 bes-> bes a2
          bes4 (c) d2 a4 e' d2\fermata
        } 
      }
   >>
>>