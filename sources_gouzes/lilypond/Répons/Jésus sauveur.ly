\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g f
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Dansant" %2 = 52
          g8-. a-. ([g-.]) a-. ([b-.]) g4.\resp
          g8^\markup\italic"librement et acceler." a [b] b [b] a [b] c4\espressivo a4.\resp
          c\breve*1/16 b8 [a] b ([c]) b4.\resp
          g8-.^\markup\italic"rallentir rythmiquement" a-. [g-.] a-. [b-.] g2.\fermata
          \bar"|."
        } \transpose g a \tonVIaf % pas de ton dans l’orig.
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d8 e4 fis d4. d8 d [g] g [g] g [g] g4 g4.
          g\breve*1/16 g8 [g] g4 g4.
          d8 e [e] fis [fis] d2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Jé -- sus sau -- veur,
      toi qui as fait de Do -- mi -- ni -- que
      "le messager de" ta Pa -- ro -- le,
      lou -- ange et gloire à toi.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 c ([b]) c ([d]) b4. 
          b8 c [d] d [d] c [d] e4 c4.
          e\breve*1/16 d8 [c] d ([e]) d4.
          b8 c [b] c [d] b2.
        } \transpose g a \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8-. g4-- d-- g4.\resp
          g8 g [g] g [g] g [g] g4 g4.\resp
          g\breve*1/16 g8 [g] g4 g4.\resp
          g8-. g-. [g-.] d-. [d-.] g2.\fermata
        } 
      }
   >>
>>

% %\transpose f g
% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \key f \major \cadenzaOn \tonRVIgf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \key f \major \cadenzaOn \tonRVIgh }
% >>