\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2. = 72
         \oneVoice r4 \voiceOne a g a2.\resp a-> a4-> b c d2-> (a4) a2. \allowBreak
         \oneVoice r2 \voiceOne b4 c-> b c a2\allowBreak b4 c-> (b) c a->\resp 
         d-- d-- d---> c b a2->\resp
         b4 c2 a4 a2.\fermata
         \bar"|."
       } \transpose b a \tonVIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         s4 fis e fis2. fis fis4 e d e2 (g4) fis2.
         s2 g4 e e e fis2 g4 e2 e4 fis d d d e g g2 g4 g2 g4 fis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ou -- vrez_- vous, por -- tes é -- ter -- nel -- les_!
     Le fort, le vail -- lant, c’est le Sei -- gneur,
     le vain -- queur de la mort, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }


      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1.5 . 2)\markup { "" } >2 
          d4 d2. d d4 c b a2 (d4) d2. s2 d4 c c c d2 b4 a2 g4 a
          g a b c d e2 e4 e2 c4 d2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d4 d2.\resp d-> d4-> a' g a2.-> d, 
          \oneVoice r2 \voiceTwo g4 a-> a a d,2 g4 a2-> e4 d->\resp
          e-- fis-- g---> a b c2->\resp c4 a2 a4 d,2.\fermata
        } \transpose b a \tonVIIch
      }
   >>
>>