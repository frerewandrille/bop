\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 52
         g4 a-> a b g2. fis4-> g e d2.\resp
         d2 e4 g2. a4-> a b g2. g\fermata
         \bar"|."
       } \transpose bes g \tonVIIIaf
       %\tonVIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 fis fis fis d2. d4 d c b2. b2 c4 d2. fis4 fis fis d2. d
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que vi -- ve mon âme à te lou -- er_!
     Que j’e -- xulte en ta pa -- ro -- le_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 d d d b2. a4 b g g2. g2 g4 b2. d4 d d b2. b
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 d-> d d g2. d4-> b c g2.\resp
          g2 c4 g2. d'4-> d d g2. g\fermata
        } \transpose bes g \tonVIIIah
        %\tonVIeh
      }
   >>
>>