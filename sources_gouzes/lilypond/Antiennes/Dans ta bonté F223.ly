\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 60
          f2^\< a4 bes g2^> a f2\!\resp
          g2 bes4 bes g g bes bes a2 a\fermata
          \bar"|."
        } \tonIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c2 f4 f e2 e d e g4 g e e g g f2 f
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Dans ta bon -- té, Sei -- gneur, 
      tu m’as com -- blé de ta Pa -- ro -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 c4 d c2 c a c d4 d c c d d d2 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 bes, c2-> a d\resp c g'4 g c, c g' g d2 d\fermata
        } \tonIhh
      }
   >>
>>