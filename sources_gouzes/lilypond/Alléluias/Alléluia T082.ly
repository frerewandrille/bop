\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"
% \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 100
          f2 g a2. (g4) a2\resp bes a2. g4 f2\fermata\resp
          e4 f g2. (f4 g2 a) f1\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { 
          c2 c f4 (e d e) f2 f4 (g) f (e) 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1 . -2)\markup { "" } >2
          c c4 c d1. (e2) c1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 bes c2. (bes4) c2 d c2. bes4 a2 
          bes4 a bes2. (a4 bes2 c4 bes) a1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f f (c) f4 (e)\resp d (e) f2. g4 a2\fermata\resp
          g4 f f (e d2 c1) f\fermata
        } 
      }
   >>
>>