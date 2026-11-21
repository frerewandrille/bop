\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose f d
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << %\accidentalStyle neo-modern-voice
       \new Voice = "soprano"
       { \voiceOne \relative c'
         { \clef "treble" \armure \cadenzaOn \tempo "Calme" 4 = 72
           f4 f8 [f] a4 a8 [a] bes4. bes8 bes [bes] bes4 (a) a2\bar"|"
           c8 [d] bes4 bes8 [bes] bes [bes] g4 g f2\fermata
           \bar"|."
         } \tonVIIIbf
       }
       \new Voice = "alto"
       { \voiceTwo \relative c'
         { 
           f4 f8 [f] f4 f8 [f] g4. g8 g [g] g4 (f) f2
           a8 [a] g4 g8 [g] f [f] ees4 ees c2
         }    
       }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       Lors -- que tu jeû -- nes, par -- fu -- me_- toi la tê -- te,
       pour ton Pè -- re, qui voit dans le se -- cret_!
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { %\accidentalStyle neo-modern-voice
          \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            d4 d8 [d] c4 c8 [c] ees4. ees8 ees [ees] ees4 (c) c2
            f8 [f] d4 d8 [d] d [c] bes4 c8 ([bes]) a2
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c'
          { 
            bes4 bes8 [bes] f4 f8 [f] ees4. ees8 ees [ees] ees4 (f) f2
            f8 [f] g4 g8 [g] d [d] ees4 ees f2\fermata
          } \tonVIIIbh
        }
     >>
  >>