\version "2.24.0"

\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key g \major \time 3/4 }
\defineBarLine "|" #'("|" "" "")
\defineBarLine "|." #'("|." "" "")
barPoint = { \bar "!" \noBreak }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new StaffGroup %ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \relative c'' {
    << { b\breve a8 [b] g4 \bar"|" b\breve g8 a ([b]) a 
         \barPoint g \barPoint g2 } \\
       { g\breve g8 [g] g4 g\breve 8 e4 fis8 d d2 } >>
    \bar"|."
    }
  }

  \addlyrics
  { 
    \set stanza = #"Pâ (1.)" \set shortVocalName = \markup\right-align"1." 
    "De grand matin, le premier jour "
    \repeat unfold 3 \skip4 
    "Voici que se lève sur nous "
  }
  \addlyrics
  { 
    %\set shortVocalName = \markup\right-align"1." 
    \retrait "de la semaine, ' il s’est levé d’en" -- tre les morts_:
    \retrait "l’aurore du jour nouveau ' qui"
    n’au -- ra \skip4 pas de fin.
  }
  \addlyrics
  { 
    \set stanza = #"Lu (2.)" \set shortVocalName = \markup\right-align"2." 
    "Par sa mort, il a vain" -- cu la mort_:
    "aux morts, il a" don -- né \skip4 la \skip4 Vie_!
  }
  \addlyrics
  { 
    \set shortVocalName = \markup\right-align"3." 
    \repeat unfold 4 \skip4 
    "Rendons grâce à Dieu "
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"Ma (3.)" 
    "Où est-elle, ô Mort," ta vic -- toire_?
    \once \override LyricText.X-offset = #6
    "qui nous donne la victoire ' par notre" Sei -- gneur \skip4  Jé -- sus Christ_!
  }
  \addlyrics
  { 
    \set stanza = #"Me (4.)" \set shortVocalName = \markup\right-align"4." 
    "Vous cherchez Jésus de Nazareth ' le" Cru -- ci -- fié_:
    "Il est ressusctié : ' voici le lieu où il avait" é -- té \skip4 dé -- po -- sé.
  }
  \addlyrics
  { 
    \set stanza = #"Je (5.)" \set shortVocalName = \markup\right-align"5." 
    "Allez dire à Pierre et à ses disciples ' qu’il vous précède en" Ga -- li -- lée_!
    "C’est là que vous le verrez ' comme il vous" l’a -- vait \skip4 an -- non -- cé.
  }
  \addlyrics
  { 
    \set stanza = #"Ve (6.)" \set shortVocalName = \markup\right-align"6." 
    "Pourquoi cherchez-vous le Vivant par" -- mi les morts_?
    "Il n’est pas ici. ' Il est ressuscité comme il" l’a -- vait \skip4 pro -- \skip4 mis_!
  }
  \addlyrics
  { 
    \set stanza = #"Sa (7.)" \set shortVocalName = \markup\right-align"7." 
    "Puisque nous sommes morts avec lui, '"\repeat unfold 3 \skip4 
    "la mort sur lui n’a plus d’empire : '"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    %\set shortVocalName = \markup\right-align"7." 
    \retrait "nous ressusciterons avec lui" pour la Vie_;
    \retrait "Christ est ressu" -- sci -- té \skip4 des \skip4 morts_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" Dox (8.)" \set shortVocalName = \markup\right-align"8." 
    "Gloire au Père, au Fils, au" Saint Es -- prit,
    "dans les siècles" des siè -- \skip4 cles._'_ A -- men_!
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \relative c' {
    << { d\breve c8 [d] b4 \bar"|" d\breve b8 c ([d]) c b b2 } \\
       { g\breve g8 [g] g4 g\breve 8 c,4 d8 g g2 } >>
    }
  }
>>