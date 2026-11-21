\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 84
         e8 [g] a4. c8 c ([a16 c] e8 [d]) c [a] a4.\resp
         e'8 e [d] e ([fis] e [d] c) [d] e4 a, a2\fermata
         \bar"|."
       } \tonIIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e8 [g] a4. a8 a4 (c8 [b]) a [g] fis4. 
         c'8 c [b] c16 ([b a8] c [b] a) [b] c4 g fis2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que Si -- on e -- xul -- te de joie pour ta vic -- toi -- re sur la mort_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e8 [g] a4. e'8 fis4 (g8 [fis]) e [e] d4.
          g8 g [fis] g ([fis] g [fis] e) [fis] g4 e d2
        } \tonIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 [g] a4. a8 d4 (c8 [d]) a [c] d4.\resp
          c8 c [d] c ([d] c [d] a) [d] c4 c d2\fermata
        } 
      }
   >>
>>