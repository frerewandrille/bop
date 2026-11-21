\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff  %\with { instrumentName = #"4" }
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn \tempo  4 = 74
          g8 [g] a [g] g4. g8 g [g] fis [a] b4 ( a8 [b] c4 b8 [a]) b4. \breathe \allowBreak
          b8 b ([c]) a [a] g4. \allowBreak e8 g [a] a ([g]) g2 \fermata \bar "|."
        } \tonVIef
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        {
          d8 [d] e [e] d4. d8 d [d] d [d] g2 (a4 fis) g4. g8 g4 e8 [e] d4. c8 e [e] e4 d2
      } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Tou8 -- tes les na -- tions4. vien8 -- dront te ren -- dre gloi1 -- re.4. 
     Ras8 -- sem4 -- ble8 nos cœurs4. pour8 qu’ils t’a -- do4 -- rent_!2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          b8 [b] c [c] b4. b8 b [b] a [c] d4 (c8 [d] e4 d8 [c]) d4. d8 d ([e]) c [c] b4. c8 b [c] c4 b2
        } \tonVIeh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          g8 [g] g [g] g4. g8 g [g] a [a] g2 (c,4 d) g4. \breathe g8 g4 g8 [a] b4. a8 e [c] e ([g]) g2\fermata
      } }
   >>
>>