\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose c a, {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << %\accidentalStyle neo-modern-voice
       \new Voice = "soprano"
       { \voiceOne \relative c''
         { \clef "treble" \armure \cadenzaOn \tempo "Très large, paisible" 2 = 44
          c4 c c2 c4 c f f e d c2\bar"|"
          c\breve*1/8 c2^\> a\fermata\!\resp 
          c\breve*1/8^\> c2 c\fermata d\fermata^\pp\!
           \bar"|."
         } 
       }
       \new Voice = "alto"
       { \voiceTwo \relative c''
         { 
          a4 a a2 a4 a a a a a a2 a\breve*1/8 g2 fis 
          g\breve*1/8 g2 a a
         } \tonXaf
       }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
      Je vous donne un com -- man -- de -- ment nou -- veau_:
      "Aimez-vous les uns les " au -- tres
      "comme je vous " ai ai -- més.
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { %\accidentalStyle neo-modern-voice
          \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
          f4 f f2 f4 e d d c d f2 f\breve*1/8 e2 d 
          e\breve*1/8 c2 e fis
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c
          { 
          f4 f f2 f4 f f f f f f2 
          f\breve*1/8 c2 d\fermata\resp
          c\breve*1/8 e2 a\fermata d,\fermata
          } \tonXah
        }
     >>
  >>
}

% \transpose c a, {
%   \new ChoirStaff
%   << 
%     \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRVcf }
%     \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRVch }
%   >>
% }