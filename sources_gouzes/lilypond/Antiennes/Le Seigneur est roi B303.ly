\version "2.24.0"
%\include "TonsDef.ly"

\transpose a e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          a8^- [a^-] c^- [a^-] a4\fermata\breathe e'16 [e e e] d8 [d] c16 [(b) c8 a] a4.\fermata\bar "|."
        }\tonVIIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          fis8 [fis] g [g] fis4 g16 [g g g] a8 [a] g [g g] fis4.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Le Sei -- gneur est roi_! Que tou -- te la terre ex -- ul -- te -- de joie_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
          d8 [d] e [e] d4 e16 [e e e] fis8 [fis] e16 [(d) e8 e] d4.
        }\tonVIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d8-- [d--] a'-- [c--] d4\fermata\breathe c16 [c c c] d8 [d] a [a c] d4.\fermata
        }
      }
   >>
>>