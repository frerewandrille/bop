\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

accel = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "accel." )))
decale = \once \override DynamicText.X-offset = #10
armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         bes\breve*1/8 c4 c2\resp
         c4 c d2\! d4 d bes2 \bar "|" 
         \decale bes\breve*1/8\accel^\< c4 c2\resp
         c4 c d2\! d4-- bes-- c-- c2\fermata          
         \bar"|."
       } \tonIIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g\breve*1/8 g4 a2 a4 a a2 a4 a g2
         g\breve*1/8 a4 a2 a4 a a2 a4 g a a2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "Si nous mourons avec " le Christ, 
     a -- vec lui nous vi -- vrons_!
     "Si nous souffrons avec " le Christ, 
     a -- vec lui nous ré -- gne -- rons_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 e4 f2 f4 f d2 d4 d d2
          d\breve*1/8 f4 f2 f4 f fis2 fis4 d f f2
        } \tonIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 c,4 f2\resp f4 f fis2 fis4 fis g2
          g\breve*1/8 f4 f2\resp f4 f d2 d4-- g-- f-- f2\fermata
        } 
      }
   >>
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIIjf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIIjh }
% >>