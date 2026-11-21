\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Violent" 2. = 56
          bes2 bes4 a2 a4 bes2. g\fermata\resp 
          g4^\< g g a2. a4 a a bes2. c d1.\fermata\!
          \bar"|."
        } \tonIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g4 g2 fis4 g2. g g4 g g fis!2. fis4 fis fis g2. g a1.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Dé -- trui -- sez ce Tem -- ple, et en trois jours, 
      je le re -- lè -- ve -- rai_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 d2 d4 d2. e e!4 e e d2. d4 d d d2. e! fis1.
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 d'2 d4 g,2. c\fermata\resp 
          c4 c c c2. c4 c c bes2. a d,1.\fermata
        } 
      }
   >>
>>