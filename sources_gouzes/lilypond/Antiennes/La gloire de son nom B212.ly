\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time  3/4 \cadenzaOn \tempo 4 = 88
          d8 a' [a] a [g] a2 b8 ([d] c) [b] a2. \breathe 
          a8 [b] g4 (a8 [b] c [b]) a4 g a a2\fermata
          \bar "|."
        } \tonVIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d8 fis [fis] fis [e] fis2 g4 (e8) [e] fis2. 
          fis8 [fis] e2 (e8 [c]) d4 b e d2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      La gloi -- re de ton Nom res -- plen -- dit 
      sur la ter -- re comme au ciel_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \key g \major\cadenzaOn
          d8 d [d] d [d] d2 d'4 (c8) [c] d2. d8 [d] b4 (c8 [b] a [g]) fis4 g g fis2
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          d8 d [d] d [d] d2 g4 (a8) [a] d,2. \breathe
          d8 [d] e2 (c8 [e]) fis4 e c d2\fermata
        }
      }
   >>
>>