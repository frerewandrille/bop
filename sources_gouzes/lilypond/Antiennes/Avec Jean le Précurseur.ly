\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     e\breve*1/8 fis'4 g fis2\resp 
     a\breve*1/8 g4 fis g2\resp
     g4^\< a2.\! a4^\> g2 g fis\!
     \bar"|."
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e\breve*1/8 fis4 g fis2\resp 
         a\breve*1/8 g4 fis g2\fermata\resp
         g4 a2. a4^\markup\italic"rallent." g2 g fis\fermata
         \bar"|."
       } \transpose bes g \tonVIIIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         cis\breve*1/8 d4 d d2 fis\breve*1/8 d4 d d2
         d4 d2. d4 d2 e d
       }    
     }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "Avec Jean le" Pré -- cur -- seur, 
     "marchons à la suite" du Sei -- gneur.
     Ve -- nez, a -- do -- rons_- le_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a\breve*1/8 a4 b a2 c\breve*1/8 b4 a b2
          b4 c2. c4 b2 cis <a d>
        } \transpose bes g \tonVIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a\breve*1/8 d4 d d2\resp
          d\breve*1/8 d4 d g2\fermata\resp
          g4 fis2. fis4 g2 a d,\fermata
        } 
      }
   >>
>>