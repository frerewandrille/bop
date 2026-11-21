\paper { line-width = #(+ line-width (* mm 4)) }
#(set-global-staff-size 13)

%\include "TonsDef.ly"
%\include "TonsRDef.ly"
\include "vowel-set.ly"

\layout { ragged-last = ##t
          \context { \Staff
                     \override Script.font-size = #-1
                     \override TimeSignature.style = #'single-digit
          }
          \context { \Lyrics
                     \override LyricText.font-size = #4
                     \override LyricText.font-name = #"EB Garamond"
                     \override LyricSpace.minimum-distance = #1
                     \override LyricText.X-offset = #centrer
          }
          \context { \Score \remove "Bar_number_engraver" }
}