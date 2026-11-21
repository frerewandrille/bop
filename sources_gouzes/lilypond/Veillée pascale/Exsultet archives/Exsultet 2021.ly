\version "2.24.0"
\include "vowel-set.ly"

\paper {
  #(set-paper-size "a5" )
  %system-system-spacing.basic-distance = #17
  top-margin = 9
  bottom-margin = 10
  left-margin = 10
  right-margin = 10
  print-page-number = ##f
  tagline = ""
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  page-count = 6
}

#(set-global-staff-size 16)

\layout {
  %  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
  } 
}

\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}

\header {
  title = \markup \center-column { "Exsultet" }
  subtitle = ""
  poet = ""
  composer =  ""
} 
\markup{ \vspace #1 }

\include "Exsultet 2021 Commandes.ly"

\new Staff \with {\remove Time_signature_engraver }
<< 
  \cadenzaOn \key f \major
  \new Voice = "melodie" \relative c'' { 
    \musA
  }

  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "melodie" {
    \textA
  }
>>
\score {
  \new Staff \with {\remove Time_signature_engraver }
  << 
    \cadenzaOn \key f \major
    \new Voice = "melodie" \relative c' { 
      \musDial
    }

    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "melodie" {
      \textDial
    }
  >>
  %\layout { indent = #0 }
}
\new Staff \with {\remove Time_signature_engraver }
<< 
  \cadenzaOn \key f \major
  \new Voice = "melodie" \relative c' { 
    \musBI\break\musBII\break\musBIII
  }

  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "melodie" {
    \textBI\textBII\textBIII
  }
>>
