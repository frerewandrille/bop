\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 52
          c\breve*1/8 c2\resp c\breve*1/8 b4 c d2 c4 b c (b) a2\bar"|"
          a\breve*1/8 a2\resp a\breve*1/8 a2 a4 g a1\fermata
          \bar"|."
        } \tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e\breve*1/8 e2 e\breve*1/8 d4 e f2 e4 e e2 e
          e\breve*1/8 e2 e\breve*1/8 e2 e4 e e1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "Nous étions" morts, "et nous sommes" re -- ve -- nus à la vi -- e. 
     "Nous étions per" -- dus, "et tu nous" as re -- trou -- vés_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a\breve*1/8 a2 a\breve*1/8 a4 a a2 a4 gis a (b) c2
          c\breve*1/8 c2 c\breve*1/8 b2 b4 b c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a\breve*1/8 a2 \resp a\breve*1/8 a4 a d2 e4 e e2 e
          e\breve*1/8 e2\resp e\breve*1/8 e2 e4 e a,1\fermata
        } \tonIIIah
      }
   >>
>>