\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose f e
\new ChoirStaff
<< \new Dynamics 
   {
     f4 f f c' c2 . d c4 bes g bes2 d4 c2
     c4 d d bes g2 a4 bes2 g4 f2. f
     ees2^\pp^\< g4 bes2 (c4) c2.\! \silN d4^\> c bes g bes c2\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Dansant"% 2 = 52
         f4 f-> f c' c2 . d c4-> bes g bes2-> d4 c2\resp
         c4 d-> d bes g2-> a4 bes2 g4 f2. f\fermata\resp
         ees2 g4 bes2 (c4) c2. \silN d4 c bes-> g bes c2\fermata
         \bar"|."
       } \transpose e f \tonVIIif
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 f f f f2. f f4 c ees f2 f4 f2 
         f4 f f g ees2 f4 f2 ees4 c2. c
         c2 ees4 d2 (f4) f2. s4 f f d ees d f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu es le ma -- tin qui a pré -- cé -- dé le jour,
     la lam -- pe qui mon -- tre la lu -- miè -- re_!
     Jean_- Bap -- tis -- te, in -- ter -- cè -- de pour nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 f f a a2. bes a4 bes bes bes2 bes4 a2 
          a4 bes bes bes c2 c4 d2 bes4 a2. a
          g2 c4 bes2 (a4) a2. \silN bes4 a bes bes bes a2
        } \transpose e f \tonVIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f-> f f f2. bes, f'4-> g ees d2-> bes4 f'2\resp
          f4 bes,-> bes ees c2-> f4 bes,2 ees4 f2. f\fermata\resp
          c2 c4 g'2 (f4) f2. s4 bes,4 f' g-> ees g f2\fermata
        } 
      }
   >>
>>