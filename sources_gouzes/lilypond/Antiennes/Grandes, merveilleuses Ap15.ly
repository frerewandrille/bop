\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff  
<< 
  \new Dynamics 
  { a4^\< a^\>  a2 \!
    a\breve^\< g4\! a b2 c4^\> b a2\!
    a4^\< g2^\> g4 g fis2\!  \bar "||"
  }
  \new Staff \with {\remove Time_signature_engraver }
  << \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \key g \major \cadenzaOn
         a2  a2 \fermata \breathe
         a\breve^\markup{\italic accel.} g4 a b2-> c4 b a2 \breathe\allowBreak
         a4g2-- g4 g fis2 \fermata \bar "||" %\noBreak
       } \transpose a g\tonVIIcf %Pas de ton dans l’original
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c' 
       { \cadenzaOn 
         fis2 fis fis\breve d4 d g2 g4 g fis2 fis4 d2 d4 d d2
       }
     }
  >>
  
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "soprano"
  { 
    Gran -- des,  merveilleuses sont tes œu -- vres,
    Sei -- gneur, ô Roi des na -- tions_!
  }
  \new Staff \with {\remove Time_signature_engraver }
  << \new Voice = "ténor" 
     { \voiceOne \relative c'
       { \clef "bass" \key g \major \cadenzaOn 
         d2 d c\breve b4 c d2 e4 d c2 c4 b2 b4 b a2
       }\transpose a g\tonVIIch
     }
     \new Voice = "basse" 
     { \voiceTwo \relative c
       { \cadenzaOn 
         d2 d\fermata \breathe d\breve g4 g g2-> g4 g d2 \breathe
         d4 d2-- d4 d d2 \fermata
       }
     }
  >>
  
>>