\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key fis \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose fis g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         fis2 eis1 fis2 fis g1 fis2 e1 e2 dis1\fermata\bar"|"
         fis2 gis a a1 \allowBreak a2 a g fis1\fermata\resp
         gis gis2 a fis1 \allowBreak fis2 fis1 eis2 fis1\fermata fis\fermata
         \bar"|."
       } \transpose c a, \tonIIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         cis2 cis1 cis2 d d1 d2 b1 b2 b1 dis2 e e fis1 fis2 fis e cis1
         e e2 e d1 d2 cis1 cis2 cis1 cis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je don -- ne ma vie pour mes bre -- bis.
     J’ai le pou -- voir de la don -- ner, 
     et le pou -- voir de la re -- pren -- dre.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 gis1 a2 a b1 a2 g!1 g2 fis1 b2 b cis d1 d2 d b ais1
          b1 b2 cis a1 b2 gis1 gis2 ais1 ais
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          fis2 cis1 fis2 d g1 d2 e1 e2 b1\fermata
          b2 e a, d1 d2 d e fis1\fermata\resp
          e1 e2 cis d1 b2 cis1 cis2 fis1\fermata fis\fermata
        }   \transpose c a, \tonIIIah
      }
   >>
>>

% \transpose fis g
% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIIgf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIIgh }
% >>