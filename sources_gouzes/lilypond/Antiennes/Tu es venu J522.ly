\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         bes\breve*1/8 d4 c bes2 f \allowBreak a a4 c2 c4 c bes2\resp
         bes\breve*1/8 c4 
         d\breve*1/8 c4 bes c2\resp
         c\breve*1/8 bes2 bes \allowBreak
         bes4 g2 g4 g bes2 bes
         \bar"|."
       } \transpose a bes \tonVIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f\breve*1/8 bes4 g f2 d f f4 f2 f4 f f2
         f\breve*1/8 f4 bes\breve*1/8 g4 g g2
         f\breve*1/8 f2 f f4 ees2 ees4 ees f2 f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto "soprano"
   {
     "Tu es venu" dans ton tem -- ple, toi l’A -- gneau im -- mo -- lé,
     "toi le" flam -- "beau de la nouvelle Jé" -- ru -- sa -- lem,
     "le vrai Temple dont nous" som -- mes les pier -- res vi -- van -- tes.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 f4 ees d2 bes c c4 ees2 ees4 ees d2
          d\breve*1/8 ees4 f\breve*1/8 ees4 d ees2
          ees\breve*1/8 d2 d bes4 bes2 bes4 c d2 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes\breve*1/8 bes4 bes bes2 bes f f4 a2 a4 a bes2\resp
          bes\breve*1/8 bes4 bes\breve*1/8 bes4 bes bes2\resp
          a\breve*1/8 bes2 bes d,4 ees2 ees4 ees bes2 bes
        } \transpose a bes \tonVIIdh
      }
   >>
>>