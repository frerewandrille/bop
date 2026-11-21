\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose fis gis
\new ChoirStaff %\with { instrumentName = #"1" }
<< \new Staff %\with {\remove Time_signature_engraver } 
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key bes \major \time 2/2 \cadenzaOn  \tempo "Très lent et grave" %2 = 69
          fis1 g a fis! \breathe\allowBreak g2 a bes1 (a2) g1 g2 fis!1 \bar "|"
          fis!2 g1 (a2 bes) bes a bes1 \breathe\allowBreak bes2 bes a1 (g2) g1 fis!2 g1\bar "|."
        } \transpose e g \tonIIcf 
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { d1 d2 (ees) ees1 d d2 d d1. bes1 c2 d1 d2 d1 (f) g2 f f1 f2 f f1 (d2) ees1 d2 d1
        }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { Nous an -- non -- çons un Mes -- sie cru -- ci -- fié, 
     Puis -- san -- ce de Dieu et Sa -- ges -- se de Dieu_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \cadenzaOn
          a1 bes c2 (bes) a1 g2 fis g1 (fis!2) g1 g2 a1 a2 bes1 (d) c2 c d1 d2 d c1 (bes2) c1 a2 bes1
        } \transpose e g \tonIIch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { d1 g2 (ees) c1 d \breathe bes2 a g (bes d) ees1 ees2 d1 
          d2 g1 (f2 d) ees f bes,1 \breathe bes2 bes f'1 (g2) c,1 d2 g1
        }
      }
   >>
>>% 
% 
% \transpose fis gis
% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \key bes \major \cadenzaOn \tonRIIcf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \key bes \major \cadenzaOn \tonRIIch }
% >>