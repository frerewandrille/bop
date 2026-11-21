\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     g2^\< a2. a4 c^\> c a c b2\!
     a4 a g^\> g e e f2 e\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 75
         g2 a2. a4 c-> c a c b2\fermata\resp
         a4-> a g g e e f2 e\fermata
         \bar"|."
       } \tonIIIif
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 f2. f4 e e f e g2 e4 e e e c c d2 b
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sans fin, je cher -- che ton sa -- lut, 
     car j’es -- père en ta Pa -- ro -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 c2. c4 c c c c d2 c4 c b b a a a2 gis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 f2. f4 a-> a f a g2\fermata\resp
          a4-> a e e a a d,2 e\fermata
        } \tonIIIih
      }
   >>
>>