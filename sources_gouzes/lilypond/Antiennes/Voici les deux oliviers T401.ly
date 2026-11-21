\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          a\breve*1/8 g4 a bes2 bes4 bes bes2 bes4 g2\resp
          g\breve*1/8 g2 g4 bes a2\fermata\bar"|"
          c\breve*1/8 d2 d4 bes2\allowBreak
          bes4 bes bes g2 g4 a2 a\fermata
          \bar"|."
        } \tonVIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f\breve*1/8 f4 f f2 f4 f g2 g4 ees2 
          ees!\breve*1/8 e2 e4 e f2
          f\breve*1/8 f2 f4 g2 g4 g g e!2 e4 f2 f
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      "Voici les deux" o -- li -- viers et les deux flam -- beaux
      "qui brillent de" -- vant le Sei -- gneur_!
      "Ils ont pouvoir de fer" -- mer le ciel 
      et d’en ou -- vrir les por -- tes.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c\breve*1/8 bes4 c d2 d4 d ees2 ees4 bes2
          bes\breve*1/8 c2 c4 c c2
          a\breve*1/8 bes2 bes4 bes2 bes4 bes bes c2 c4 c2 c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/8 f4 f f2 f4 f ees2 ees4 ees2\resp
          ees!\breve*1/8 c2 c4 c f2\fermata
          f\breve*1/8 bes,2 bes4 ees!2 ees4 ees ees c2 c4 f2 f\fermata
        } \tonVIdh
      }
   >>
>>