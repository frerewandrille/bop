\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          a\breve*1/16 a2\resp
          a\breve*1/16 bes2\bar "|" 
          bes4 bes bes2 bes4-- bes-- a-- a-- a2\fermata          
          \bar"|."
        } \tonVIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f\breve*1/16 fis2 fis\breve*1/16 g2 g4 g g2 g4 g f f f2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      "Éveille-toi, ô toi qui" dors,
      "relève-toi d’entre les" morts,
      et le Christ t’il -- lu -- mi -- ne -- ra_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c\breve*1/16 d2 d\breve*1/16 d2 d4 d e2 e4 e c c c2
        } \tonVIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/16 d2\resp
          d\breve*1/16 g2 g4 g c,2 c4-- c-- f-- f-- f2\fermata
        } 
      }
   >>
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRVIhf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRVIhh }
% >>