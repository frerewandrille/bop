\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
         \silN a4-> a2.\fermata\resp a4-> a2\fermata\resp 
         \override TextScript.outside-staff-priority = #1
         d2 d4 c c2\resp c4^\markup\italic"rall."^\> c
         bes2 a a1\fermata\!
         \bar"|."
       } \tonImf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         s4 e f2. e4 f2 f bes4 g a2 a4 a g2 e f1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dieu saint, Saint fort, Saint im -- mor -- tel, 
     prends pi -- tié de nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \silN cis4 d2. cis!4 d2 d2 d4 e f2 f4 f d2 cis! d1
        } \tonImh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          s4 a4-> d,2.\fermata\resp a'4-> d,2\fermata\resp
          bes bes4 c f2\resp f4 f g2 a d,1\fermata
        } 
      }
   >>
>>