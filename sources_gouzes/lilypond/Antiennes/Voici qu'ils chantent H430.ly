\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Très doux"% 2 = 52
          g4 g2 g4 a2 a4 bes2 g4 fis2\allowBreak a4 bes2 (c4) bes2 a4 bes2\bar"|"
          bes4 bes2 bes4 a2 g4 g2 fis4 g2\resp
          g4 fis!2 g4 a2 a4 bes2 a4 g2 (fis4) g2.\fermata
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { 
          d4 d2 d4 f2 f4 f2 ees4 d2 fis4 g2 (a4) f 
          \override BalloonText.annotation-balloon = ##f 
          <f \balloonText #'(1.5 . -2)\markup { "" } >2
          d
          f4 f2 f4 f2 d4 ees 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1.5 . -2)\markup { "" } >2
          d d4 d2 e4 f2 f4 f2 f4 d2. d
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Voi -- ci qu’ils chan -- tent dans les cieux 
      le chant de l’A -- gneau,
      car Dieu ef -- fa -- ce de leurs yeux
      tou -- te souf -- france et tou -- te lar -- mes.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 bes2 bes4 c2 c4 d2 c4 a2 d4 d2 (f4) d 
          \override BalloonText.annotation-balloon = ##f 
          <c \balloonText #'(1.5 . 2)\markup { "" } >2
          d
          d4 d2 d4 c2 b4 c 
          \override BalloonText.annotation-balloon = ##f 
          <a \balloonText #'(1.5 . 2)\markup { "" } >2
          bes bes4 a2 c4 c2 d4 d2 c4 bes (a2) b2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g2 g4 f2 f4 bes,2 c4 d2 d4 g2 (f4) bes f2 bes,
          bes'4 bes2 bes4 f2 g4 c, d2 <g, g'>\resp
          bes4 d2 c4 f2 d4 bes2 f'4 g (d2) <g, g'>2.\fermata
        } \tonIIah
      }
   >>
>>