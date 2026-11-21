\version "2.24.0"

\include "Exsultet 2021 Commandes.ly"
\include "Ft-Gar.ly"


\paper {
  #(set-paper-size "a5" )
  top-margin = 9
  bottom-margin = 10
  left-margin = 10
  right-margin = 10
  print-page-number = ##f
  tagline = ""
}

#(set-global-staff-size 16)

\layout {
  indent = #0
  \context { 
    \Score 
    \remove "Bar_number_engraver" 
    %proportionalNotationDuration = #(ly:make-moment 1)
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2.5
    \override LyricSpace.minimum-distance = #1
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}

\bookpart {
  \markup{
    \fill-line {
      \center-column {
        \null\vspace #12 \bold \fontsize #8
        {"Exsultet"}
      }
    }
  }
}

\bookpart {
  \paper { 
    page-count = 6 
    ragged-last-bottom = ##f
  }
  \new Staff \with {\remove Time_signature_engraver }
  << 
    \cadenzaOn \key f \major
    \new Voice = "melodie" { \Mus-Intro }

    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "melodie" { \Texte-Intro }
  >>

  \markup { \vspace #15 }
  \new StaffGroup
  <<
    \override Score.SystemStartBar.collapse-height = #4
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \cadenzaOn \key f \major
      \new Voice = "melodie" { \Mus-dial }

      \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
      \lyricsto "melodie" { \Texte-dial }
    >>
  >>
  \pageBreak
  \new StaffGroup
  <<
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \cadenzaOn \key f \major
      \new Voice = "melodie" { \musBI\break\musBII\break\musBIII }

      \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
      \lyricsto "melodie" { \textBI\textBII\textBIII }
    >>
  >>
}
