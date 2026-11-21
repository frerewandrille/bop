\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }


\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 54
          bes2 bes2 bes4-> bes a-> a g2 g4 g g2 f g1\fermata\allowBreak
          g4 g g2 g4 (f) g1\fermata
          \bar"|."
        } \transpose g bes \tonIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f f4 f f f d2 d4 d d2 d d1 d4 d ees2 d d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Voi -- ci que je vous en -- voie com -- me des bre -- bis
      au mi -- lieu des loups.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d d4 d c c bes2 bes4 bes a2 a b1 b!4 b c2 a b!1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes2 bes bes4-> bes f-> f g2 g4 g d2 d g1\fermata
          g4 g c,2 d g1\fermata
        } \transpose g bes \tonIIdh
      }
   >>
>>