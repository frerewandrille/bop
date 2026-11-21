\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose f e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 72
         f4 g-> bes c2. c4 c-> c bes-> c d2 (c4 bes) c2.\resp
         g2^\markup{\dynamic p \italic " sub. en élargissant"} 
         g4-> g ees-> g bes-> a g-> (f) f2\fermata
         \bar"|."
       } \tonVIIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 g bes f2. f4 f f f f f2 (g4 bes) f2.
         g2 ees4 ees ees ees g f ees (c) c2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Re -- dres -- sez_- vous et re -- le -- vez la tê -- te,
     car vo -- tre dé -- li -- vrance est pro -- che_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 g bes a2. a4 a a bes a bes1 a2. 
          bes2 bes4 bes c c d d bes (a) a2
        } \tonVIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 g-> bes f2. f4 f-> f d-> c bes2 (ees4 g) f2.\resp
          ees2 ees4-> ees c-> c g'-> d ees-> (f) f2\fermata
        } 
      }
   >>
>>