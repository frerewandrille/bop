\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo "Large" 2 = 56
          b2 b4 b b b a a b b e,2.\breathe\allowBreak e4 g^> g fis e fis2 e1\fermata
          \bar"|."
        }\transpose a b \tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g4 g fis fis e e fis fis e2. b4 c c d d d (c) b1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      C’est la mi -- sé -- ri -- cor -- de que je veux,_ et non le sa -- cri -- fi -- ce.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          d2 d4 d d d c c d c b2. g4 a a fis g a2 g1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 g d d e e d d e2.\breathe e4 a,_> a b b b2 e1\fermata
        }\transpose a b \tonIch
      }
   >>
>>