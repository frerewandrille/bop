\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  %\with { instrumentName = #"3" }
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn \tempo "Calme" 4 = 76
          e,8 g [a] b4 b4. \breathe \allowBreak b8 b [b] b [b] a [g] b4\fermata \breathe \allowBreak 
          b4 b8 [b] a [b] c4 (g8 [a]) b4.  \breathe \allowBreak b8 b4 a b2 \fermata \bar "|."
          b \breve a8 c4 \bar "|" \noBreak b \breve c \breve a8[ c] b4 \bar "||" \noBreak b \breve  a4-+ \bar "|."
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        {
          e8 g [a] b4 b4. g8 g [g] g [g] g [g] g4 g g8 [g] g [g] a ([g] e4) g4. g8 g4 e8 ([fis]) g2
          fis \breve s8 g4 \bar "|" fis \breve g \breve s4 fis4 \bar "||" fis \breve  fis4
      } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      É8 -- gli -- se sain4 -- te,4. Jé8 -- ru -- sa -- lem ai -- mée de Dieu,4 
      mè -- re8 de tous les hom2 -- mes,4. bé8 -- nie4 sois_- tu_!2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          e,8 g [a] b4 b4. d8 d [d] e [e] e [e] d4 d d8 [d] e [d] e4 (c) d4. d8 d4 c <b e>2
          d \breve s8 e4 \bar "|" d \breve e \breve s4 d4 \bar "||" d \breve d4
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          e,8 g [a] b4 b4. \breathe b8 b [b] c [c] c [c] g4\fermata \breathe g4 g8 [g] c [b] a4 (c) g4. \breathe
          g8 g4 a e2\fermata
          d \breve s8 a4 \bar "|" d \breve a \breve c8[ a] b4 \bar "||" d \breve d4
      } }
   >>
>>