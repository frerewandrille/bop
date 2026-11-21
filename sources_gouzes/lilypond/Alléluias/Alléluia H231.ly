\version "2.24.0"

% \include "vowel-set.ly"
% \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "Calme" 4 = 69
         a8 [gis a] b4 cis8 d4 b8 cis4 (a8) \bar"|"
         a8 [gis a] b4 cis8 d4 b8 cis4.
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e8 [e e] fis4 a8 b4 gis8 a4 (e8)
         e8 [e e] fis4 a8 b4 gis8 a4.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          cis8 [b cis] d4 e8 fis 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1 . 3)\markup { "" } >4
          e (cis8)
          cis8 [b cis] d4 e8 fis 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1 . 3)\markup { "" } >4
          e4.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a8 [e a] a4 a8 d b4 a4. a8 [e a] a4 a8 d b4 a4.
        } 
      }
   >>
>>