\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2. = 69
         g4 a b-> b c b-> b b a-> a a b-> b b g2 g4 \allowBreak a2 a4 b2.\resp
         b4->^\markup\italic"élargir" b b g2 g4 a2 a4 a2.\fermata
         \bar"|."
       } \transpose b a \tonVIIcf %pas de ton dans l’original
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 fis g g g g g g fis fis fis fis fis fis
         e2 e4 fis2 fis4 fis2. fis4 fis fis e2 e4 e2 e4 fis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ren -- dez grâce au Sei -- gneur 
     qui a fait tou -- tes cho -- ses nou -- vel -- les
     dans le Christ
     car é -- ter -- nel est son a -- mour.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 d d d e d d d d d d dis dis dis 
          b2 b4 d2 d4 dis2. dis!4dis dis b2 b4 cis2 cis4 d2.
        } \transpose b a \tonVIIch %pas de ton dans l’original
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 d g-> g c, g'-> g g d-> d d b-> b b e2 e4 d2 d4 <b b'>2.\resp
          b'4-> b b e,2 e4 a2 a4 d,2.\fermata
        } 
      }
   >>
>>