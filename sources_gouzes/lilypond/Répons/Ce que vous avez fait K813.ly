\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 2/4 }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2 = 69
         g2 g4-> g a-> b b2. b4 a-> b c-> b a-> g b2 a1\bar"|"
         g4-> a a2 a4-> b a-> g g1\fermata
         \bar"|."
       } \transpose a b \tonVIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 d4 e fis e fis2. fis4 e fis g fis e e e2 fis1
         e4 fis fis2 fis4 fis e e d1
       }    
     }
   >>
   \new Lyrics \lyricsto "soprano"
   {
     Ce que vous a -- vez fait au plus pe -- tit d’en -- tre mes frè -- res,
     c’est à moi que vous l’a -- vez fait.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 b4 b d e d2. d4 c d e d c b b2 d1
          b4 c d2 d4 d c c b1
        } \transpose a b \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 fis4-> e d-> c d2. d4 e-> d c-> d e-> g c,2 d1
          e4-> e d2 d4-> d e-> e g1\fermata
        } 
      }
   >>
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRVIjf } % ou k
%   \addlyrics
%   {
%   }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRVIjh }
% >>