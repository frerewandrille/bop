\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 80
         bes8 g [f] g [bes] bes4. (c8 bes [g] bes [c]) bes4.\resp
         d8 d [c] bes4.\resp
         bes8 c [d] d ([c] bes4.) g8 g [bes] bes4
         \bar"|."
       } \tonVIIIcf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c'
       { 
         f8 g [f] g [bes] f4 (g f ees) f4. f8 g [g] f4.
         f8 f [g] a4 (g4) 
         \override BalloonText.annotation-balloon = ##f 
         <d \balloonText #'(1 . -2)\markup { "" } >
         g8 [g] f4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu nous as fait re -- vi -- vre, Sei -- gneur Jé -- sus,
     toi qui nous don -- nes le sa -- lut_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 ees [f] ees [ees] d4 (ees d c) d4. d8 ees [ees] d4.
          d8 ees [ees] f4 (d) 
          \override BalloonText.annotation-balloon = ##f 
          <bes \balloonText #'(1 . 3)\markup { "" } >
          ees8 [ees] d4
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes8 c [d] c [c] bes2. (g4) bes4.\resp
          bes8 ees, [ees] bes'4.\resp
          bes8 bes [bes] f4 (g) bes c8 [c] bes4
        } \tonVIIIch
      }
   >>
>>