\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     d2.^\< d4 ees2 ees d2.^\> d4 bes2 c d1\!\bar"|"
     a2 a4 a bes1\resp 
     bes2^\< bes4 bes c2^\> c a1\!\bar"|"
     a2^\< bes2. bes4 c2 c\! d\resp
     d2^\> c bes a1 a2 g1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2 = 69
         d2. d4 ees2 ees d2.d4 bes2 c d1\fermata\bar"|"
         a2^\markup{\italic "avec insistance" } a4 a bes1\resp 
         bes2 bes4 bes c2 c a1\fermata\bar"|"
         a2 bes2. bes4 c2 c d\fermata\resp
         d2 c bes a1 a2 g1\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g2. g4 g2 g fis2. fis4 g2 g fis1 
         d2 d4 d d1 d2 d4 d ees2 ees d1
         d2 d2. d4 e2 e fis! fis g g g1 fis!2 d1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je suis cru -- ci -- fié a -- vec le Christ,
     et si je vis, c’est n’est plus moi qui vis,
     mais c’est Jé -- sus Sei -- gneur, le Christ, qui vit en moi.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2. bes4 c2 c a2. a4 g2 g a1 
          fis2 fis4 fis g1 g2 g4 g g2 g fis!1
          fis!2 g2. g4 g2 g a a g g g1 a2 b1
        } 
      }
      \new Voice = "basse"\with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { 
          g2. g4 c,2 c d2. d4 ees2 ees d1\fermata
          d2 d4 d g,1\resp g2 g4 g c2 c d1\fermata
          d2 g 
          \override BalloonText.annotation-balloon = ##f 
          <f \balloonText #'(1.5 . 3)\markup { "" } >
          e e d\fermata\resp d ees d ees1 d2 <g, g'>1\fermata
        } \tonIIah
      }
   >>
>>