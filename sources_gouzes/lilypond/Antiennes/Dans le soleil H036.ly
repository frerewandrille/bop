\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f4 e f g g g c c bes a2 g4 a bes g f2.
         \bar"|."
       } \tonVIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c4 c d e e e f e e f2 e4 f f e c2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Dans le so -- leil, il a fait sa de -- meu -- re, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 bes a g c bes a g g f2 c'4 c d bes a2.
        } \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 bes a g c bes a g g f2 c4 f bes, c f2.
        } 
      }
   >>
>>