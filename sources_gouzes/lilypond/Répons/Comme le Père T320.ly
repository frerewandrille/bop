\version "2.24.0"
% %\include "TonsDef.ly"
% %\include "TonsRDef.ly"

\new ChoirStaff %\with { instrumentName = #"1" }
<< \new Staff %\with {\remove Time_signature_engraver } 
   << \new Voice = "soprano" 
      { \voiceOne \relative c''
        { \clef "treble" \key d \major \time 2/2 \cadenzaOn  \tempo "Calme" 2 = 69
          a2 a4 a d2 d4 d cis2 a b\fermata\breathe fis4 fis g2. g4 a2 g4 (a) fis1\fermata\bar "|."
        }
        \transpose a b \tonIVef 
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { fis2 fis4 fis fis2 fis4 gis a2 cis, fis dis4 dis e2. e4 cis2 cis dis!1
        }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { Com -- me le Pè -- re m’a en -- voy -- é, moi aus -- si, je vous en -- voie.
      
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key d \major \cadenzaOn
          d2 d4 d d2 d4 d e2 fis4 (e) dis2 b4 b b2. b4 a2 a b1
          }
        \transpose a b \tonIVeh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { d2 d4 cis b2 b4 b a (gis) fis2 <b, b'>\fermata\breathe 
          b4 b e2. e4 fis2 e4 (cis) b1\fermata
        }
      }
   >>
>>

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }{ \key d \major \cadenzaOn \tonRIVbf  }
  \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \key d \major \cadenzaOn \tonRIVbh }
>>