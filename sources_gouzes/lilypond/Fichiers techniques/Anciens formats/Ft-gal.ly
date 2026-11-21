\version "2.24.0"

\paper {line-width = #(+ line-width (* mm 4)) }

\include "TonsDef.ly"
\include "TonsRDef.ly"
\include "vowel-set.ly"
\layout {
  \context { \Staff
             \override Script.font-size = #-1
             \override TimeSignature.style = #'single-digit
  }
  \context { \Lyrics
             \override LyricSpace.minimum-distance = #1
             \override LyricText.font-size = #2
  }
  \context { \Score
             \remove "Bar_number_engraver"
  }
}

Garamond = \layout {
  \context { \Lyrics
             \override LyricText.font-name = #"EBGaramond08"
             \override LyricText.font-size = #2.5
  }
}

TeXGyrePagella = \layout {
  \context { \Lyrics
             \override LyricText.font-name = #"TeXGyrePagella"
             \override LyricText.font-size = #2
  }
}
