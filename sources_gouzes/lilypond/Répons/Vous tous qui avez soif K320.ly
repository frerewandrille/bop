\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Lent" 4 = 88
          a4 a2 a4 a a c2 bes4 a f g2\fermata\resp
          g4 g2 a4 f g a2\resp 
          a4^\markup\italic"plus calme" a g f2 g4^\markup\italic"rall." f e2\fermata
          \bar"|."
        }  \transpose b a \tonIIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f2 f4 f f f2 f4 f c e2 e4 e2 e4 d d cis2 cis4 d d d2 d4 d cis!2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Vous tous qui a -- vez soif, ve -- nez à moi_! 
      Ô Christ, sour -- ce de vie, ré -- pands en nous ton Es -- prit_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c2 c4 c c c2 d4 c a c2 c4 c2 c4 a d, e2 e4 f g a2 bes4 a a2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f2 f4 f f a2 bes4 f f c2\fermata\resp
          c4 c2 a4 d bes a2\resp a4 d bes a2 g4 a a2\fermata
        }  \transpose b a \tonIIIdh
      }
   >>
>>