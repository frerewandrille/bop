\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key e \minor \time 2/2 }
resp = { \breathe }

\transpose g f
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \relative c''
     { \clef "treble" \armure \tempo  2 = 80
       g4 fis e2 g4 a b2 d4 a b2\resp
       g4 fis e2 g4 a b2 g4 a fis fis \noBreak e2\fermata
       \bar "|."
     }\break\cadenzaOn \transpose a b \tonIef
   }
   \new Lyrics \lyricsto soprano 
   { 
     Bien -- heu -- reux ceux qui cher -- chent la paix.
     Bien -- heu -- reux les cœurs purs, car ils ver -- ront Dieu.
   }
   \new Staff
   \new Voice = "alto"
   { \relative c''
     { \armure
       R1 g4 fis e2 g4 a b2 d4 a b2\resp
       g4 fis e2 g4 a b2~ b\fermata
     }          
   }
   \new Lyrics \lyricsto alto 
   { 
     Bien -- heu -- reux ceux qui cher -- chent la paix.
     Bien -- heu -- reux les cœurs purs.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   \new Voice = "ténor"
   { \relative c'
     { \clef "G_8" \armure
       r2 g4 fis e2 g4 a b2 d4 a b2\resp
       g4 fis e2 g4 a b2 d4 a b2\fermata
     }
   }
   \new Lyrics \lyricsto ténor 
   { 
     Bien -- heu -- reux ceux qui cher -- chent la paix.
     Bien -- heu -- reux, bien -- heu -- reux les cœurs purs.
   }
   \new Staff
   \new Voice = "basse"
   { \relative c'
     { \clef "bass" \armure
       R1 r2 g4 fis e2 g4 a b2 d4 a b2\resp
       g4 fis e2 c4 c e2\fermata
     }\cadenzaOn \transpose a b \tonIeh
   }
   \new Lyrics \lyricsto basse 
   { 
     Bien -- heu -- reux ceux qui cher -- chent la paix.
     Bien -- heu -- reux les cœurs purs.
   }
>>