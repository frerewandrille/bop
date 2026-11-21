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
    title = "DIALOGUES DE LA MESSE"
    tagline = ##f
  }

  \markup { 
    \vspace #2 \fill-line\bold \fontsize #2 { "Ouverture et Évangile" }}

  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve f4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Le Seigneur soit avec"\breve vous...4
      }
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve f \break \allowBreak f4 g4\bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Évangile de Jésus-Christ se" \breve -- \gauche "lon saint" Mat4 -- thieu...4
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \skip \breve  \skip \breve \skip 4 Marc...4
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \skip \breve  \skip \breve \skip 4  Luc...4
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \skip \breve  \skip \breve \skip 4  Jean...4
      }
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve f g4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Acclamons la Pa"\breve -- \gauche "role de" Dieu...4
      }
    >>
  }
%  \pageBreak
  \markup { 
    \vspace #2 \fill-line\bold \fontsize #2 { "Préface" }}

  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c' { 
        \key f \major \cadenzaOn
        d4 f g a g g f4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        Le Sei -- gneur soit a -- vec vous...4
      }
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve bes g4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Éle"\breve -- "vons notre" cœur...4
        \gauche "Éle"\breve -- "vons notre" cœur...4
      }
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve bes g a4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Rendons"\breve \gauche "grâce au Sei" -- \gauche "gneur notre" Dieu...4
      }
    >>
  }
  \markup { 
    \vspace #2 \fill-line\bold \fontsize #2 { "Bénédiction" }}

  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve f4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Le Seigneur soit avec"\breve vous...4
      }
 
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g\breve \break \allowBreak g f4 \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Que Dieu tout-puissant vous bénisse :"\breve \gauche "le Père, et le Fils, et le Saint Es" -- prit_!..4
      }
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key f \major \cadenzaOn
        g4 g2 f4 g bes bes g \bar"|."
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
      Al -- lez2 dans4 la paix du Christ...
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
}