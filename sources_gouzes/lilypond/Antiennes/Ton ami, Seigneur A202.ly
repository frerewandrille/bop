\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2. = 50
         e2 e4 g2 a4 a2. a4 a a g2 g4 a2 b4 b2\resp
         b4 b-> b b g-> g g e-> e g a2\resp
         a4 g2 e4 e2.\fermata
         \bar"|."
       } \transpose b a \tonVIIgf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e2 e4 e2 e4 e2. e4 e e e 2 e4 e2 fis4 fis2
         fis4 fis fis fis b, b b c! c b e2 e4 e2 e4 e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ton a -- mi, Sei -- gneur, n’a pas con -- nu la cor -- rup -- tion_:
     Tu lui as ou -- vert le che -- min de la Vie, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e2 e4 b'2 cis4 cis2. cis4 cis cis d2 d4 cis2 dis4 dis2
          dis!4 dis dis dis e e e e e d cis!2 cis4 d!2 d4 cis2.
        } \transpose b a \tonVIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 e4 e2 a4 a2. a4 a a b2 b4 cis2 b4 b2\resp
          b4 b-> b b e,-> e d c-> c e a2\resp
          a4 b2 b4 a2.\fermata
        } 
      }
   >>
>>