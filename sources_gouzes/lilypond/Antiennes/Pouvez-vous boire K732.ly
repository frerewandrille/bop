\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     a4^\< a a c2 b4 a b2^\> e,1\! 
     e2^\< f4 g a2^\> e1\!\resp
     a4^\< g f e d d e f f2.^\> f4 e2 d e1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 40
         a4 a-> a c2 b4 a b2 e,1\fermata\allowBreak
         e2\fermata f4\fermata g\fermata a2\fermata e1\fermata\resp
         a4 g f e d d e f f2. f4 e2 d e1\fermata
         \bar"|."
       } \tonIVcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e e e2 f4 a e2 e1 cis2 d4 cis! d2 b1 
         c4 e d cis d \allowBreak d cis! d d2. d4 b2 b b1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pou -- vez_- vous boi -- re la cou -- pe que je vais boi -- re,
     et ê -- tre plon -- gés dans le bap -- tê -- me de ma mort_?
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c a2 a4 a gis (a) b1 bes2 a4 bes! a2 gis1
          a4 b a bes a a bes! a a2. a4 gis2 a gis!1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a4 a-> a a2 d4 f e (fis) gis!1\fermata
          g2\fermata f4\fermata e\fermata f2\fermata e1\fermata\resp
          a,4 e' f g f f e d d2. d4 e2 f e1\fermata
        } \tonIVch
      }
   >>
>>