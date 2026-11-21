\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"
         \revert Staff.TimeSignature.style
         b\breve c4^\markup\italic"pizz." (b8-. [a-.] b4-.-> c-.) b4.\allowBreak
         8 c4-> (b8 [a]) \agauche g4^\rall^\> a g2\!\bar"|"
         b4-. c-. d-. (c8-. [b-.] a4-.-> b8-. [c-.] b4-.-> a-.) b2\resp
         b\breve a8 b4.\resp c8 d4 (c8 [b] a4->) a b2\fermata
         \bar"|."
       } \tonVIpf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g\breve 1 4. 8 4. (d8) 4 4 2 g4 4 1. 2 \breve 8 4. 8 2. 4 2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "Royaumes de la" ter -- re, chan -- tez au Sei -- gneur_!
     Il s'é -- lè -- ve "au plus haut" des cieux, à l'O -- ri -- ent.
   }
   \new Staff \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \revert Staff.TimeSignature.style
          d\breve e4 (d8 [c] d4 e) d4. 
          8 e4 (d8 [c]) b4 c b2
          d4 e f (e8 [d] c4 d8 [e] d4 c) d2
          \breve c8 d4. e8 f!4 (e8 [d] c4_>) c d2
        } \tonVIph
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve 
          << { g1 }
             \new Dynamics \with {
               \override VerticalAxisGroup.nonstaff-relatedstaff-spacing =
               #'((basic-distance . 0.5)
                  (minimum-distance . 0.5)
                  (padding . 0.25)
                  (stretchability . 0))
             }
             { e4 (d8-. [c-.] d4-._> e-.)  }  
          >>
          g4. 8 c,4-> (d) d d <g, g'>2
          g'4-. g4-. 
          << { 1. }
             \new Dynamics \with {
               \override VerticalAxisGroup.nonstaff-relatedstaff-spacing =
               #'((basic-distance . 0)
                  (minimum-distance . 0)
                  (padding . -1)
                  (stretchability . 0))
             }
             { f4-. (e8-. [d-.] c4-._> d8-. [e-.] d4-._> c-.)  }  
           >>
          2\resp \breve 8 4.\resp 8 2. d4 g2\fermata
        } 
      }
   >>
>>