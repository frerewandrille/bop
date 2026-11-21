\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Très doux et calme" 4 = 63
         f4 g8 [a] a4 d c bes a2\resp
         f4 g8 [a] a2 (g4 f) g2\fermata\resp
         g4 a8 [bes] a4 a \allowBreak a8 [a] g [f] g2 f\fermata
         \bar"|."
       } \tonVIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 f8 [f] f4 bes bes f f2 c4 f8 [f] f2 (d) e
         e4 e8 [e] f4 f f8 [f] d [d] e2 c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Bé -- ni sois_- tu, Sei -- gneur Jé -- sus,
     A -- gneau sans ta -- che,
     toi qui en -- lè -- ves les pé -- chés du mon -- de.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 bes8 [c] c4 f e d c2 a4 bes8 [c] c2 (bes4 a) bes2
          bes4 c8 [d] c4 c c8 [c] bes [a] bes4 (c) a2
        } \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f8 [f] f4 f f f f2\resp
          f4 f8 [f] f1 c2\fermata\resp
          c4 c8 [c] f4 f f8 [f] f [f] c2 f\fermata
        } 
      }
   >>
>>