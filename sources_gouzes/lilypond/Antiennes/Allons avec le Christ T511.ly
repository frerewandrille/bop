\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d {
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 108
          e4 f-> f e-> e f2 f4 f a2 c4 c a2\fermata\resp
          a4-> a e'-> e d e a,2 a4 a c2 (a) a1\fermata
          \bar"|."
        } \tonIdf        %\tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          cis4 d d cis cis d2 d4 f f2 e4 e fis2
          fis!4 fis g g g g fis!2 fis4 fis g1 fis! 
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lons a -- vec le Christ et mou -- rons a -- vec lui_! 
      Il est la ré -- sur -- rec -- tion et la vi -- e_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a a a a a2 a4 d c2 c4 c d2 d4 d e e e e d2 d4 d e1 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 d,-> d a'-> a d,2 d4 d f2 a4 a d2\fermata\resp
          d,4-> d a'-> a c c d2 d4 d a2 (c) d1\fermata
        } \tonIdh        %\tonIeh
      }
   >>
>>
}