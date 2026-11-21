\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Dynamics 
   {
     a4 a a a2 e'4 e2 d4 a2.
     a2^\< a4 c2.\! b4 a c a2.^\pp^\> a\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  2. = 50
         a4-> a a a2 e'4 e2 d4 a2.\resp
         a2 a4 c2. b4-> a c a2. a
         \bar"|."
       } \tonIIIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e e e2 e4 f2 g4 a2. 
         g2 fis4 e2. fis!4 e fis! g2 (fis!4) e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ou -- vre mes yeux, Sei -- gneur mon Dieu,
     aux splen -- deurs de ta Pa -- ro -- le.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c b2 b4 a2 b4 c2. c2 d4 e2. d4 c d e2 (d4) <c e>2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4-> a a g2 g4 f2 f4 e2.\resp
          e2 d4 a2. d4-> e d c2 (d4) <a a'>2.
        } \tonIIIgh
      }
   >>
>>