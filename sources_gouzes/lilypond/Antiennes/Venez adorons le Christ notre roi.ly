\version "2.24.0"
%\include "TonsDef.ly"

\transpose g d
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn
          g4 g^> g8 [g] fis4 g a a8 [a] b2 \breathe \allowBreak
          b8 ([a]) b [c] d2 \allowBreak e4 d8 [c] b4 g a a g2\fermata \bar "|." 
        } \transpose a b \tonVIcf % Pas de ton dans l’original
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Ve4 -- nez, a8 -- do -- rons4 le Christ no8 -- tre roi,2 
     ac4 -- cla8 -- mons_- le2 dans 4 l’as8 -- sem -- blée4 de tous les saints.2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          b4 b b8 [b] a4 b c c8 [c] d2 d8 ([c]) d [e] g2 g4 g8 [g] d4 b c c b2
        } \transpose a b \tonVIch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          g4 g-> g8 [g] d4 g d d8 [d] g2 \breathe g4 g8 [g] b2 c4 b8 [a] g4 g d d g2 \fermata
        } 
      }
   >>
>>