\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

rall = #(make-dynamic-script 
         (markup #:line ( #:normal-text #:italic "rall." )))

\new ChoirStaff  
<<
  \new Dynamics { 
    b4 a b g2 a4 e2. e4 d e g2 (e4) e2.
    e4 d e g2 g4 a (g) a b2.
    e2 e4 d (e d) b2
    b4 a ( b^\>\rall) a g2. (e2 d4) g2.\! \bar "||"
  }
  \new Staff %\with {\remove Time_signature_engraver }
  << \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \key g \major \cadenzaOn 
         \tempo  2. = 50
         b4-> a b g2 a4 e2. e4-> d e g2 (e4) e2. \breathe\allowBreak
         e4-> d e g2 g4 a-> (g) a b2. \breathe\allowBreak
         e2 e4 d-> (e d) b2 \breathe\allowBreak
         b4 a (b) a g2. (e2 d4) g2.\fermata \bar "||"
       } \tonVIef
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { \cadenzaOn 
         g4 fis fis e2 e4 c2. a4 b a b2 (a4) b2.
         c4 b c b2 b4 d2 d4 d2. g2 g4 g2. g2
         g4 fis2 fis4 e2. (c) d
       }
     }
  >>
  
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricmode 
  { \set associatedVoice = #"soprano" 
    Vous4 qui m’a -- vez2 sui4 -- vi2. dans 4 mes é -- preu2. -- ves,
    vous4 man -- ge -- rez2 et4 vous2 boi4 -- rez2.
    à2 ma4 ta2. -- ble2 dans4 mon2 Roy4 -- au1. -- me.2.
  }
  \new Staff %\with {\remove Time_signature_engraver }
  << \new Voice = "ténor" 
     { \voiceOne \relative c'
       { \clef "bass" \key g \major \cadenzaOn 
         d4 d d b2 a4 g2. e4 fis e d2 (e4) e2.
         g4 a g g2 g4 fis4 (e) fis g2. g2 a4 b4 (c b) d2
         d4 d2 d4 b2. (a) b2.
       }\tonVIeh
     }
     \new Voice = "basse" 
     { \voiceTwo \relative c'
       { \cadenzaOn 
         g4-> d d e (d) c c2. c4-> b c g2 (c4) e2. \breathe
         e4-> fis e d2 d4 d2 d4 g,2. \breathe
         c2 c4 g'2. g2 \breathe g4 d2 d4 e2. (a) g\fermata
       }
     }
  >>
  
>>