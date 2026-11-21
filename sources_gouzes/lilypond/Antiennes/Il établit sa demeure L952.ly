\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose f d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Calme" 4 = 72
          f4 f8 [f] a4 a8 [a] bes4. bes8 bes [bes] a2\bar"|"
          c8 [d] bes4. bes8 bes [bes] g4 g a2 a\fermata
          \bar"|."
        } \tonVIIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f8 [f] f4 f8 [f] g4. g8 g [g] f2 
          a8 [a] g4. g8 g [g] ees4 ees f2 f
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Il é -- ta -- blit sa de -- meu -- re dans la paix.
     En Si -- on il a fi -- xé sa ten -- te.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d8 [d] c4 c8 [c] ees4. ees8 ees [ees] c2
          f8 [f] d4. d8 d [d] c4 c c2 c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 bes8 [bes] f4 f8 [f] ees4. ees8 ees [ees] f2
          f8 [f] g4. g8 g [g] c4 c f,2 f\fermata
        } \tonVIIIbh
      }
   >>
>>