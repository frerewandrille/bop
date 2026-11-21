\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17) indent = 0

armure = { \key f \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIgf }

  \addlyrics
  { 
    \set stanza = #"(I V) 1." \set shortVocalName = \markup\right-align"1." 
    "Voici qu’il vient sur les nuées du" ciel.
    "Il a reçu la royau" -- "té, la gloire et la" puis -- sance_:
    "Le Fils de l’homme n’est pas venu pour être" ser -- vi, mais pour ser -- vir
    "et donner sa vie en" ran -- çon "pour la" mul -- ti -- tude.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    
  }
  \addlyrics
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 

  }
  \addlyrics
  { 
    \set stanza = #"(L) 5." \set shortVocalName = \markup\right-align"5." 
    "Dieu a tout réconciler par lui sur la terre comme au" ciel,
    "établissant la" "paix par le Sang de" sa croix.
    "Quand je serai élevé" de terre, j’attirerai tout à moi_!
    "Si quelqu’un a soif, qui vienne" à moi, "et je lui donne" -- rai l’eau vive.    
  }
  \addlyrics
  %\with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"(II V) 6." \set shortVocalName = \markup\right-align"6." 
    "Ce Jésus que vous avez cruci" -- fié,
    "Dieu l’a fait Seigneur et" "Christ en le ressuscitant" des morts_:
    "Il lui a donné" le Nom au-dessus de tout nom_:
    "Roi des rois et Seigneur des" Sei -- gneurs, "pour les siè" -- cles des siècles.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"(Dox.) 7." \set shortVocalName = \markup\right-align"7." 
    "Gloire au Père qui nous appelle à la joie du Royau" -- me.
    "Gloire au Christ Sau" -- "veur exalté dans" la gloire.
    "Gloire à l’Esprit" d’A -- mour, "le Seigneur" de la vie.
    "Trinité bien" -- heu -- reuse, "louange et" gloire à toi.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" (Magn.) 8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIgh }
>>