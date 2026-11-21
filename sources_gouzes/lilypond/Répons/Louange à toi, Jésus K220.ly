\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2. = 50
          g4 b a g2 a4 b2 d4 c2 c4 b2.\resp d2 b4 c2. b4 a g a2. g\bar"|"
          g4 b a g2 a4 b2 d4 c2. b\resp d4 b c b2. a2 (g4) a2. g
          \bar"|."
        }  \tonVIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 g fis d2 fis4 g2 g4 g2 fis4 g2. g2 g4 g2. g4 fis d e2 (fis4) d2.
          d4 g fis d2 fis4 g2 g4 g2 (fis4) g2. g4 g g g2. d e2 (fis4) d2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Lou -- ange à toi, Jé -- sus trans -- fi -- gu -- ré_! 
     Les dis -- ciples ont vu ta gloi -- re 
     pour qu’en ta croix, ils te con -- tem -- plent, 
     toi, la splen -- deur du Pè -- re.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 d c b2 c4 d2 d4 e2 d4 d2. b2 d4 e2. d4 c b c2. b
          b4 d c b2 c4 d2 d4 e2 (d4) d2. b4 d e d2. c2 (b4) c2. b
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g d g2 d4 g2 b4 a2 a4 g2.\resp g2 g4 c,2. g'4 d d d2. g
          g4 g d g2 d4 g2 b4 a2. g2.\resp g4 g4 c, g'2.d d g
        }  \tonVIfh
      }
   >>
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRVIcf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRVIch }
% >>