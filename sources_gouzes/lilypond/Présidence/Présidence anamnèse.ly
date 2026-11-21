\version "2.24.0"

gauche = { \once \override LyricText.self-alignment-X = #LEFT }

\paper {
  #(set-paper-size "a6")
  top-margin = 10
  left-margin = 8
  right-margin = 8
  bottom-margin = 10 
  print-page-number = #f
}

#(set-global-staff-size 18)



\bookpart { 
  \header {
    %    title = "DIALOGUES DE LA MESSE"
    tagline = ##f
  }

  \markup { 
    \vspace #2 \fill-line\bold \fontsize #2 { "Anamnèse" }}

  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve bes g a4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Il est"\breve \gauche "grand, le mys" -- \gauche "tère de la" foi...4
      }
    >>
  }
%  \pageBreak
  \markup { 
    \vspace #2 \fill-line\bold \fontsize #2 { "Doxologie" }}

  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g4 bes\breve a g4 a \breathe \allowBreak
        g bes\breve \breathe \allowBreak
        bes\breve a g4 a4\breathe \allowBreak
        bes\breve a4 bes c c bes bes \breathe \allowBreak
        bes\breve g a4 a \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        Par4 \gauche "lui, avec"\breve \gauche "lui et" en4 lui, 
        à4 \gauche "toi, Dieu le Père tout-puissant,"\breve  \gauche" dans l’uni" --
        \gauche "té du Saint" Es4 -- prit,
        \gauche "tout hon"\breve -- neur4 et tou -- te gloi -- re, 
        \gauche "pour les" \breve \gauche "siècles des" siè4 -- cles...4
      }
 
    >>
  }
}

\layout {
  indent = #0
  ragged-last = ##t
  ragged-right = ##t
  \context {
    \Staff \remove "Time_signature_engraver"
  }
  \context { 
    \Voice \override Stem.length = #0 
    \override Stem.stencil = ##f }
}