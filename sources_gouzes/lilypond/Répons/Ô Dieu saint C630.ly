\version "2.24.0"
%\include "TonsDef.ly"
%%\include "TonsRDef.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         g2 a a1\fermata\resp c2 a a1\fermata\resp 
         d2 c4 bes a2\fermata\resp a4 b c2 a a1\fermata
         \bar"|."
       } \tonIIImf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e2 e fis1 g2 g fis1 fis2 e4 e fis2 fis4 fis e2 <e g> fis1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Dieu saint, ô Dieu fort, Dieu im -- mor -- tel,
     prends pi -- tié de nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 c d1 e2 e d1 d2 c4 c d2 d4 d c2 c d1
        } \tonIIImh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 a, d1\fermata\resp a2 c d1\fermata\resp 
          d2 a'4 a d,2\fermata\resp d4 d <a a'>2 q d1\fermata
        } 
      }
   >>
>>

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIIIaf }
  \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIIIah }
>>