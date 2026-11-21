\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 60
          c4-> c b-> b e,2. e4 a2 g4-> g e1\resp e4-> e e-> e d2 d4-> f e2 e\fermata
          \bar"|."
        }  \tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e e c2. c4 d2 e4 e e1 c4 c c c a2 b4 b c2 c
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Re -- ve -- nez à moi de tout vo -- tre cœur, 
      car je suis un Dieu de ten -- dres -- se.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a g g a2. a4 a2 b4 b c1 a4 a a a f2 f4 g a2 a
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a4-> a e'-> e a2. g4 f2 e4-> e <a, a'>1\resp
          a4-> a a-> a d2 d4-> d a2 a\fermata
        } \tonIVch
      }
   >>
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIVdf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIVdh }
% >>