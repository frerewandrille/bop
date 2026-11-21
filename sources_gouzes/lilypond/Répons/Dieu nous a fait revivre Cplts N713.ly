\version "2.24.0"

\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17) indent = 0

armure = { \key bes \major \time 3/4 }
\defineBarLine "|" #'("|" "" "")
\defineBarLine "|." #'("|." "" "")

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose a fis
\new StaffGroup
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \relative c'' {
    << { a\breve g8 [a] bes2 \bar"|" bes \breve c8 [bes] a2 } \\
       { fis\breve e8 [fis!] g2 g\breve a8 [g] fis!2 } >>
    \bar"|."
    }
  }

  \addlyrics
  { 
    \set stanza = #"Lu (1.)" \set shortVocalName = \markup\right-align"1." 
    "Jésus Christ ' Fils de David se" -- lon la chair,
    "établi Fils de Dieu par sa résurrection '"
  }
  \addlyrics
  { 
    %\set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    \repeat unfold 4 \skip4 
    \retrait "dans la puissance" de l’Es -- prit.
  }
  \addlyrics
  { 
    \set stanza = #"Ma (2.)" \set shortVocalName = \markup\right-align"2." 
    "Jésus Christ ' le Roi des rois et le Seigneur" des sei -- gneurs,
    "lui qui possède l’immortalité '"
  }
  \addlyrics
  { 
    %\set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    \repeat unfold 4 \skip4 
    \retrait "et demeure dans une lumière in" -- ac -- ces -- sible.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"Me (3.)" \set shortVocalName = \markup\right-align"3."
    "Jésus Christ ' manifesté dans la chair et justifié" dans l’Es -- prit_!
    "Jésus Christ ' proclamé chez les païens et enlevé" dans la gloire_!
  }
  \addlyrics
  { 
    \set stanza = #"Je (4.)" \set shortVocalName = \markup\right-align"4." 
    "Jésus Christ ' image du Dieu invisible et premier-né de toute" cré -- a -- ture,
    "premier-né d’entre les morts ' en qui habite toute la" plé -- ni -- tude.
  }
  \addlyrics
  { 
    \set stanza = #"Ve (5.)" \set shortVocalName = \markup\right-align"5." 
    "Jésus Christ ' en qui Dieu nous a fait revivre pour une vivante" es -- pé -- rance,
    "Jésus Christ ' en qui Dieu nous a pardonné tou" -- tes nos fautes.
  }
  \addlyrics
  { 
    \set stanza = #"Sa (6.)" \set shortVocalName = \markup\right-align"6." 
    "Jésus Christ ' que Dieu a livré pour nos péchés,"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set shortVocalName = \markup\right-align"6." 
    \retrait "nous accordant tou" -- te fa -- veur,
    "Jésus Christ ' ressuscité à la droite du Père et qui intercè" -- de pour nous.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" Dox (7.)" \set shortVocalName = \markup\right-align"7." 
    "Jésus Christ ' en qui le Père a fait de" nous ses fils,
    "Jésus Christ ' par qui l’Esprit a été répandu" en nos cœurs_!
  }


  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \relative c' {
    << { d\breve s4 d2 \bar"|" d\breve f!8 [d] d2 } \\
       { d,\breve s4 d2 g\breve f!8 [g] d2 } >>
    }
  }
>>