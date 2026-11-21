\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Large"% 2 = 52
         e2 e b'2. c4 b2 a g1\fermata\resp
         g2 g4 g fis2. (a4) g2 g fis1\fermata
         \bar"|."
       } \transpose a b \tonIbf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c'
       { 
         e2 e e 
         \override BalloonText.annotation-balloon = ##f 
          <dis \balloonText #'(1.5 . -1.5)\markup { "" } >
          e fis e1
         e2 e4 e e2 (dis!) e cis dis!1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur est mon ber -- ger.
     Rien ne sau -- rait me man -- quer.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g2 g4 (a) b2 
          \override BalloonText.annotation-balloon = ##f 
          <a \balloonText #'(1.5 . 2.5)\markup { "" } >
          b cis4 (dis) e1
          b2 b4 b b1 b2 b b1
        } \transpose a b \tonIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 e4 (fis) g2 fis g a b1\fermata\resp
          e,4 (fis) g a b2 (b,) e g4 (a) b1\fermata
        } 
      }
   >>
>>