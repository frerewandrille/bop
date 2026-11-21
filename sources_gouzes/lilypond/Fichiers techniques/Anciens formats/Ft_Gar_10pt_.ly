#(set-global-staff-size 12.5)
\paper {line-width = #(+ line-width (* mm 4)) }
\layout {
  \context { \Staff
             \override Script.font-size = #-1
             \override TimeSignature.style = #'single-digit
  }
  \context { \Lyrics
             \override LyricText.font-name = #"EB Garamond"
             \override LyricText.font-size = #3
             \override LyricSpace.minimum-distance = #1
  }
  \context { \Score \remove "Bar_number_engraver" }
}
%\include "TonsDef.ly"
%\include "TonsRDef.ly"
\include "vowel-set.ly"
