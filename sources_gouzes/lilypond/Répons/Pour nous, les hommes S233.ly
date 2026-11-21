\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key e \minor \time 3/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 44
          e2 fis8 [g] a2. a2 fis4 g2. a2 g8 [a] b2.\resp
          b2 b8 [b] d2 d8 [d] c2 b8 [a] b2 (g4) e2.\bar"|"
          e2 fis8 ([g]) a2 g4 fis2 fis4 e2.
          \bar"|."
        } \transpose a b \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          b2 b8 [d] e2. e2 e4 d2. e2 e8 [e] g2.
          g2 g8 [g] fis2 fis8 [fis] e2 e8 [e] d2. c
          c2 c4 e2 c4 e2 d4 b2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Pour nous, les hom -- mes, et pour no -- tre sa -- lut,
      tu as pris chair dans le sein de Ma -- ri -- e_:
      Christ Sei -- gneur, tu es bé -- ni_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g2 a8 [b] c2. c2 a4 b2. c2 c8 [c] d2.
          d2 d8 [d] b2 b8 [b] g2 g8 [g] g2. g
          g2 g4 c2 a4 b2 b8 ([a]) g2.
        } \transpose a b \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 e8 [d] c2. c2 c4 b2. a2 a8 [a] g2.\resp
          g2 g8 [g] b2 b8 [b] c2 c8 [c] g2. c
          c2 c4 a2 c4 b2 b4 e2.
        } 
      }
   >>
>>% 
% 
% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIef }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIeh }
% >>