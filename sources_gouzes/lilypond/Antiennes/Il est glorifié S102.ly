\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  %\with { instrumentName = #"8" }
<< \new Dynamics 
   {
     e8^\< [e] a4 g a8 [b] c\! ([b]) a4^\> g8 ([f]) e4\!  \breathe \allowBreak
     e8^\< [d] e [f] g4 a a8 ([b]) c4\! (g8) [a] \allowBreak g [f] e ([d] e [fis] g4 a8 [b] c4 b) g2  \breathe \allowBreak
     a8 [b] c4 b d2  \breathe \allowBreak c8 [b] a4 (g) a2   \bar "|." 
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key a \minor \cadenzaOn \tempo "Très large & majestueux"
          e8 [e] a4 g a8 [b] c ([b]) a4 g8 ([f]) e4 \fermata \breathe \allowBreak
          e8 [d] e [f] g4 a a8 ([b]) c4 (g8) [a] \allowBreak g [f] e ([d] e [fis] g4 a8 [b] c4 b) g2 \fermata \breathe \allowBreak
          a8 [b] c4 (b) d2 \fermata \breathe \allowBreak c8 [b] a4 (g) a2  \fermata \bar "|." }
        \relative c'' { a \breve g8[ a] b4 \bar "|" \noBreak a \breve b8[ g] e 4 \bar "||" \noBreak a \breve  g4-+ \bar "|." } 
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          e8 [e] e4 e e8 [g] g4 e e8 ([c]) c4 c8 [c] c [c] d4 e e8 ([g]) g4 (e8) [e] d [d] c2 (e a4 fis!) e2
          e8 [g] g2 a f8 [f] f ([e] d4) e2 }
        \relative c'' { e, \breve s4 e4 \bar "|" \noBreak e \breve s4 e4 \bar "||" \noBreak e \breve  e 4 }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Il8 est glo4 -- ri -- fié8 le Roi4 de la paix, et8 tou -- te la ter4 -- re con -- tem4. -- ple8 son vi -- sa1. -- ge_!2
     Al8 -- lé -- lu2 -- ia_! Al8 -- lé -- lu2 -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c
        { \clef "bass" \key a \minor \cadenzaOn 
          e8 [e] c'4 b c8 [d] e ([d]) c4 b8 ([a]) g4 g8 [f] g [a] b4 c c8 ([d]) e4 (c8) [c] g [g] g4 (a b c8 [b] e4 dis) b2 
          c8 [d] e4 (d) f2 a,8 [b] c4 (b) c2 }
        \relative c' { 	c \breve b8[ c] d4 \bar "|" \noBreak c \breve d8[ b] c4 \bar "||" \noBreak c \breve b4 }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          e8 [e] a,4 e' a8 [g] c, ([g']) a4 e8 ([f]) c4 \fermata \breathe \allowBreak
          c8 [c] c [c] b4 a a'8 ([g]) c,4. c8 b [b] c ([b] a4 e'8 [d] c [b] a4 b) e2 \fermata \breathe \allowBreak
          a8 [g] c,4 (g') d2 \fermata \breathe \allowBreak d8 [d] d4 (e) <a, a'>2 \fermata }
        \relative c' { 	a \breve s4 g4 \bar "|" \noBreak a \breve g8[ g] a4 \bar "||" \noBreak a \breve e4 }
      }
   >>
>>