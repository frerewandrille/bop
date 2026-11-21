\version "2.24.0"

\include "vowel-set.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure 
         \revert Staff.TimeSignature.style
         f2 g4 g f2 f d c d (f) 1 a2 c d c a f d f f1
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c2 4 4 d2 c bes a a (d) c1 2 g' f c c c bes d c1
       }    
     }
   >>
   \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
     De ton Es -- prit la terre est plei -- ne. 
     Tu rem -- plis l’u -- ni -- vers de ton feu.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          a2 g4 c a2 a f f f (bes) a1 f2 g a g f f <f bes> bes a1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 e4 c d2 a bes f' d (bes) <f f'>1 f'2 e d e f a, bes bes f'1
        } 
      }
   >>
>>