\version "2.24.0"
%\include "TonsDef.ly"

\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key d \major \time 2/2 \cadenzaOn \tempo 8 = 132
          a8 [a16 (fis)] a8 [b] a4 \breathe 
          a8 [b] d ([cis16 b] a8) [fis] a [b] a4 \bar "|"
          d8 [d16 cis] b8 [fis] a [b] b2 \fermata \bar "|."
        }\tonVIIjf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          fis8 [fis16 (e)] d8 [d16 (e)] fis4 
          fis8 [a16 (g)] fis8 ([d16 e] fis8) [e] fis16 [(e) d (e)] fis4 
          fis8 [fis16 e] d8 [b16 (cis)] d8 [d16 (e)] fis2 
        }          
      }
   >>
   \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano"
      Au8 ma -- tin, Sei -- gneur,4 que8 je chan4. -- te8 ton a -- mour_!4
      Al8 -- lé16 -- lu -- ia_!8 Al -- lé -- lu -- ia_!2
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"ténor"
      \skip1 \skip 1 \skip 4
      Al8 -- lé16 -- lu -- ia_!8 Al -- lé -- lu -- ia_!2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key d \major \time 2/2 \cadenzaOn
          d8 [cis] b16 [(a) g8] a4 d8 [cis] b _([a] d) [cis] b [a] d4
          r d8 [d16 cis] b8 [fis] a [b] <a d>4%_\fermata
        }\tonVIIjh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d8 [d] e [e] d4 \breathe d1 d4 d8 [(e)] fis [(a)] fis [(e)] d2\fermata
        }
      }
   >>
   \new Lyrics \lyricmode
   { \set associatedVoice = #"basse"
      \skip1 \skip1
      Al4 -- lé -- lu -- ia_!2
   }
>>