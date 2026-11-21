\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait
im = \set ignoreMelismata = ##t

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIImf }

  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"(I V) 1." \set shortVocalName = "1." 
    \im Aujour -- "d’hui ' le Sauveur vient" au Jour -- dain,
    "Et renouvelle" en nous le vieil homme_;
    "Il restaure par" "l’eau notre na" -- ture cor -- rom -- pue,
    "Il nous revêt du vête" -- "ment de l’im" -- mor -- ta -- li -- té.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = "2." 
    \im "Au commence" -- "ment ' les ténèbres cou" -- vraient l’a -- bîme,
    "Et l’Esprit" de "Dieu ' planait" sur les eaux_;
    "La voix du Père a reten" -- "ti : “Celui -" ci est mon Fils,
    "Mon enfant Bien - Ai" -- "mé en qui j’ai mis" tout mon A -- "mour.”"
  }
  \addlyrics
  { 
    \set stanza = #"3." \set shortVocalName = "3." 
    \im "Aussitôt bapti" -- "sé ' le Christ est remon" -- té des eaux,
    "Entraînant a" -- vec "lui ' le monde" sanc -- ti -- fié_;
    "Les cieux se sont ou" -- "verts ' et sur lui l’Esprit de" -- meu -- __ \skip4 \skip4 re.
    "Le nouvel A" -- "dam nous ouvre le Pa" -- ra -- dis nou -- veau.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4." \set shortVocalName = "4." 
    \im "Voici l’Agneau de" "Dieu ' qui porte les pé" -- chés du monde,
    "Au pouvoir de" Sa -- "tan ' il nous a" ar -- ra -- chés_;
    "Par le baptême de sa" "Croix ' nous recevons l’eau" vi -- __ \skip4 \skip4 ve.
    "Il nous entraîne à sa" "suite vers la Pâque de" sa gloi -- __ \skip4 re.
  }
  \addlyrics
  { 
    \set stanza = #"(L) 5." \set shortVocalName = "5." 
    \im Aujour -- "d’hui ' le Christ est plongé dans" la lu -- mière,
    "La colombe" d’ar -- "gent le couvre" de ses ailes.
    "Sur lui l’Esprit re" -- "pose et le pro" -- lame Bien_- Ai -- mé,
    "Le fleuve est embra" -- "sé par la pléni" -- tu -- de de Dieu.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"(II V) 6." \set shortVocalName = "6." 
    \im Aujour -- "d’hui ' la Passion est pro" -- phé -- ti -- sée,
    "Aujourd’hui la Résur" -- rec -- "tion est" an -- non -- cée_;
    "Aujourd’hui le Précur" -- "seur exulte a" -- vec le Jour -- dain,
    "Toute la terre bondit de" "joie car Dieu" a par -- don -- né.
  }
  \addlyrics
  { 
    \set stanza = #" (Dox.) 7." \set shortVocalName = "7." 
    \im "Gloire au" "Père qui a manifes" -- té le Fils,
    "Gloire" au "Fils ' en qui il met toute sa" com -- plai -- sance,
    "Gloire à l’Esprit de lu" -- "mière ' qui re" -- po -- se sur lui,
    "Trinité Sainte, gloire à" "toi ' pour les siècles" des siè -- __ \skip4 cles.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8. " \set shortVocalName = "8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIImh }
>>