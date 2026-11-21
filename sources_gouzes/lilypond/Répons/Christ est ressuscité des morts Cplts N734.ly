\version "2.24.0"

\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}


\transpose g d
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn 
    << \relative c'' { c\breve d bes4 \breathe\allowBreak bes\breve c a4 \breathe\allowBreak a\breve a bes4 \bar"|."} \\
       \relative c'' { a\breve a g4 g\breve g f4 \breve fis g4 }
    >>
  }

\addlyrics
   { 
    \set stanza = #"Lu (1.)" \set shortVocalName = \markup\right-align"1." 
    "Le Christ est mort pour nos pé" -- "chés selon les Écri" -- tures,
    "mis au tombeau et ressuscité le troisième jour ' se" -- "lon les Écri" -- tures,
    "il est apparu à Pierre et à Jacques ' et à" "tous les a" -- pôtres.
   }
  \addlyrics
   { 
    \set stanza = #"Ma (2.)" \set shortVocalName = \markup\right-align"2." 
    "Le Christ est ressuscité des morts '" \skip4 \skip4
    "la mort était venue par un seul '"  \skip4 \skip4
    "mais la vie nous est donnée par un seul '"
   }
  \addlyrics
   { 
    %\set shortVocalName = \markup\right-align"2." 
    \retrait "prémices de ceux qui se" "sont endor" -- mis_:
    \retrait "et tous nous mou" -- "rons en A" -- dam,
    \retrait "et tous nous revi" -- "vrons dans le" Christ.
 }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Me (3.)" \set shortVocalName = \markup\right-align"3." 
    "Il faut que le Christ règne sur tout ' et que" "tout lui soit sou" -- mis_;
    "et le dernier ennemi à dé" -- "truire, c’est la" mort.
    "Et quand tout lui sera soumis, ' le" "Fils se soumettra au" Père.
  }
  \addlyrics
   { 
    \set stanza = #"Je (4.)" \set shortVocalName = \markup\right-align"4." 
    "Nous semons de la corruption : ' mais il en ressus" -- "cite de l’immortali" -- té.
    "Nous semons de la faiblesse : ' mais il en ressus" -- "cite de la" force.
    "Nous semons un corps de chair, ' il en ressus" -- "cite un corps de" gloire.
  }
  \addlyrics
   { 
    \set stanza = #"Ve (5.)" \set shortVocalName = \markup\right-align"5." 
    "Le premier Adam fut créé"
  }
  \addlyrics
   { 
    \set shortVocalName = \markup\right-align"5." 
    \retrait "âme vivante, ' pour rece" -- "voir la" vie.
    "Le second Adam est Esprit qui" "donne la" vie.
    "Nos corps semés dans la terre ' ressusciteront pour" "vivre dans l’Es" -- prit.
  }
  \addlyrics
   { 
    \set shortVocalName = \markup\right-align"6." 
    \repeat unfold 6 \skip4
    "Rendons grâce à Dieu qui nous donne"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Sa (6.)" \set shortVocalName = \markup\right-align"6." 
    "La mort a été englou" -- "tie dans la vic" -- toire_:
    "Mort, où est ta victoire ? ' Mort, où" "est ton aiguil" -- lon_?
    \set shortVocalName = "" 
    \retrait "la victoire ' par Jésus" "Christ ressusci" -- té_!
  }
  \addlyrics
   { 
    \set stanza = #"Dox (7.)" \set shortVocalName = \markup\right-align"7." 
    "Gloire à toi, Père saint, '"
  }
  \addlyrics
   { 
    \set shortVocalName = \markup\right-align"7." 
    \retrait "qui as soumis toutes choses à Jé" -- "sus, le Sei" -- gneur_!
    "Gloire au Fils qui remettra sa royau" -- "té entre les mains du" Père_!
    "Gloire à l’Esprit par qui le Fils ' est devenu le Sei" -- "gneur de la" vie_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #" Magn (8.)" \set shortVocalName = \markup\right-align"8." 
    "Le premier Adam a été façonné du li" -- "mon de la" terre.
    "Le Christ, nouvel Adam, est venu du ciel dans le" "sein de Ma" -- rie
    "afin que soit gravée dans notre chair ' l’i" -- "mage de l’Adam cé" -- leste.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn 
    << \relative c' { f\breve fis d4 \breve e c4 \breve d d4 } \\
       \relative c { f\breve d g4 \breathe\breve c, f4 \breve d g4 }
    >>
  }
>>