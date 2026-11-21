\version "2.24.0"

\paper {
  #(set-paper-size "a5")
  top-margin = 12
  tagline = #"Ne pas emporter ni plier svp"
}


#(set-global-staff-size 11)

\header {
  title = \markup \center-column { "Le peuple qui marchait" }
  subtitle = " "
  poet = ""
  composer = ""
}

\layout { 
  indent = #0
  \context { \Staff
             \override Script.font-size = #-1
             \override TimeSignature.style = #'single-digit
  }
  \context { \Lyrics 	
             \override LyricText.font-size = #3.5
             \override LyricSpace.minimum-distance = #1
  } 
  \context { \Score \remove "Bar_number_engraver" }
}	
%\include "TonsDef0.ly"
\include "vowel-set.ly"

\include "Le peuple qui marchait H011.ly"
\include "Le peuple qui marchait Cpts H011.ly"