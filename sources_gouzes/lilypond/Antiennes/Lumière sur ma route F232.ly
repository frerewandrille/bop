\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
          a4^\< a2. a4^\> c c a2 a\!
          bes4^\< bes c2 c2.^\> c4 a2\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 75
          a4 a2. a4 c-> c a2 a\fermata\resp
          bes4 bes c2 c2. c4 a2\fermata
          \bar"|." 
        } \tonVIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f2. f4 e e fis2 fis g4 g g2 g2. g4 f2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Lu -- miè -- re sur ma rou -- te,
      ta Pa -- ro -- le, Sei -- gneur_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c2. c4 c c d2 d d4 d e2 e2. e4 c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f2. f4 a-> a d,2 d\fermata\resp
          g4 g c,2 c2. c4 f2\fermata
        } \tonVIgh
      }
   >>
>>