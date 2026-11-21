\version "2.24.0"
%\include "TonsDef.ly"

\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 2/2 \cadenzaOn \tempo 4 = 100
          a8 [a16 a] e'8 \breathe e d [d] c [a] \bar"|"
          a [a16 a] c8 \breathe c b16 [(a) g8] a2 \bar "|."
        }\tonIIIaf
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { %\set associatedVoice = #""
      Chante au Sei -- gneur, tou -- te la ter -- re, chante au Sei -- gneur, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 2/2 \cadenzaOn
          a8 [a16 b] c8 c d16 [(e) f8] e [e] e [e16 d] e8 e16 [(c)] d8 [d] e2
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          a8  [a16 g] f8 \breathe f16 ([e]) d8 [d] a'16 [(b) c8] 
          c [c16 b] a8 \breathe a g [b] a2
        }\tonIIIah
      }
   >>
>>