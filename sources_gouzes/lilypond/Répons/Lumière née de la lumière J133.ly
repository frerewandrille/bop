\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 54
         d4 d (fis) g a2 4 b (a) g a2 4\resp g2 b4 c2 4 b a b a2\resp
         a4 a (b) c d \allowBreak c d a b c b2. a\resp 4 a b g2 \allowBreak 4 c (b) c a2.
         \bar"|."
       } \tonVIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 2 4 e2 4 fis (e) d e2 4 d2 g4 2 4 4 4 4 fis2
         4 4 (g) a b a b fis g a g2. fis2. 4 4 4 e2 4 a2 4 fis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Lu -- miè -- re née de la Lu -- miè -- re, 
     le Sei -- gneur nous est ap -- pa -- ru,
     et sa splen -- deur il -- lu -- mi -- ne le mon -- de, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
   \new Staff \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d4 d (a') b c2 4 d (c) b c2 4 b2 d4 e2 4 d c d d2
          d4 2 4 4 4 4 4 4 4 2. 2. 4 4 4 b2 4 e (d) e d2.
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 2 4 2 4 2 4 2 4\resp g2 4 c,2 4 g' g g d2\resp
          4 2 4 4 4 4 4 4 4 2. 2.\resp 4 4 4 e2 4 a,2 4 d2.
        } 
      }
   >>
>>