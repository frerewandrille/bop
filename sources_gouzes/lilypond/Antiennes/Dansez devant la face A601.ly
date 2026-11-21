\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2. = 66
         d4-- d-- d-- a2 b8 ([cis]) d4 d b cis2.\resp
         a4 a a b2 a4 g2 4 fis2.\fermata\resp
         4 g fis g2 a4 b2 cis4 d!2.\resp
         4 a fis g2 4 fis2-- e4-- fis2.\fermata
         \bar"|."
       } \tonVef
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         fis4 4 4 e2 4 fis4 4 gis <e a>2. cis4 4 4 b4. (cis8) d4 e2 4 dis2.
         dis!4 e dis e2 fis4 g2 e4 fis2. 4 d dis e2 4 2 cis4 dis!2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dan -- sez de -- vant la fa -- ce de Deu_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Lui qui se lè -- ve comme un feu,
     et qui dis -- per -- se l'en -- ne -- mi.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 4 4 2 4 b b b a2. 4 4 4 d2 a4 b2 4 2.
          4 4 4 2 d!4 2 g,4 a2. 4 fis b b2 4 2 4 2.
        } \tonVeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d d cis2 4 b b e a,2.\resp
          fis'4 4 4 g2 fis4 e2 4 b2.\fermata\resp
          4 e b e2 d!4 g4. (fis8) e4 d2.\resp
          4 4 b e2 4 fis2 4 b,2.\fermata
        } 
      }
   >>
>>