\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 3/8 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Léger, vif"
         a8 a [g a] bes [a bes] bes ([a g]) a4.\resp
         c4 d8 d [(c bes)] c4.\bar"|" \time 2/4 \tempo "Calme" 
         a8 a [a] f [g] a4 \allowBreak a8 [a] c4 a8 [g] a2\fermata
         \bar"|."
       } \tonVIaf
     }
     \new Voice = "alto" %\with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
       { 
         f8 f\breve*6/16 f4 (e8) f4. f4 f8 f4 (d16 [e]) f4.
         f8 f [f] d [e] f4 f8 [f] e ([c]) d [e] f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Je veux con -- tem -- pler ta puis -- san -- ce
     et ta gloi -- re,
     car ton a -- mour, Sei -- gneur,
     est meil -- leur que la vie_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c8 c [bes c] d [c d] d ([c bes]) c4.
          a4 bes8 bes ([a g]) a4.
          c8 c [c] d [d] c4 c8 [c] c4 bes8 [bes] c2
        } \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 f\breve*6/16 f4 (g8) f4.\resp
          f4 bes,8 d ([f g]) f4.
          f8 f [f] bes [bes] f4 f8 [f] a4 g8 [g] f2\fermata
        } 
      }
   >>
>>