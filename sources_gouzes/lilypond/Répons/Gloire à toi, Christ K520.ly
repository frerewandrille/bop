\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Allant" 2 = 90
         g4 g a1 bes2 bes a1\resp c4 c d2 d4 d c2. c4 c2 bes a1\fermata\bar"|"
         \once \override TextScript.outside-staff-priority = #1
         a2^\markup\italic"élargir" g^\> g4 g bes bes a2 g g a1\fermata\!
         \bar"|."
       } \tonVIjf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c'
       { 
         e4 e f1 d2 e f1 f4 f f2 f4 f f2 
         \override BalloonText.annotation-balloon = ##f 
         < e \balloonText #'(1.5 . -2)\markup { "" } >
         f d4 (e) f1
         f2 e e4 e d e f2 d d4 (e) f1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Gloire à toi, Christ sau -- veur, 
     toi qui bri -- ses les por -- tes des en -- fers_!
     Tu es la ré -- sur -- rec -- tion et la vie_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c1 bes2 bes c1\resp a4 a bes2 bes4 bes a2 
          \override BalloonText.annotation-balloon = ##f 
          < bes \balloonText #'(1.5 . 2)\markup { "" } >
          c d c1
          c2 c c4 c bes bes c2 bes bes c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c4 c f1 g2 g f1 f4 f bes,2 bes4 bes f'2 g a bes f1\fermata
          f2 c c4 c g' g f2 g g f1\fermata
        } \tonVIjh
      }
   >>
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRVIff }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRVIfh }
% >>