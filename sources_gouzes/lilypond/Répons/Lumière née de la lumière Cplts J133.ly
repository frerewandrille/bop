\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 18) indent = 0

armure = { \key g \major \time 3/4 }

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
  { \armure \cadenzaOn \tonRVIIdf }

  \addlyrics
  { 
    \set stanza = "1." \set shortVocalName = \markup\right-align"1." 
    "Aujourd’hui, les" "cieux se" sont ou -- verts,
    "l’Esprit descend sur" "toi et plane" sur les eaux,
    "les portes du Para" -- "dis s’ouvrent de" -- vant ta Face,
    "et l’épée flamboy" -- "ante s’éloigne de l’arbre" de la Vie.
  }
  \addlyrics
  { 
    \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
    "Tu es venu dans la sub" -- "stance de" no -- tre chair,
    "et les mages ont" "vu ton étoile à" l’O -- ri -- ent_;
    "Tu es la Lumière des na" -- "tions et le Salut "
    \repeat unfold 3 \skip4
    "la paix pour "
  }
  \addlyrics
  { 
    \repeat unfold 11 \skip4
    \retrait "des extrémités" de la terre,
    \ptretrait "ceux qui étaient" "loin et la paix pour ceux qui" é -- taient proches.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = "3." \set shortVocalName = \markup\right-align"3." 
    "Dans ton empresse" -- "ment et dans ta" com -- pas -- sion,
    "tu es appa" -- "ru, ô Résurrec" -- tion des peuples_;
    "Les prémices des na" -- "tions se prosternent" de -- vant toi,
    "Dieu est venu sur" "terre et l’homme est remon" -- té aux cieux.
  }
  \addlyrics
  { 
    \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
    "Dieu est lu" -- "mière, en lui point" de té -- nèbres.
    "Si nous marchons"
  }
   \addlyrics
  { 
    \repeat unfold 5 \skip4
    \retrait "dans la lu" -- "mière, ' comme il est "
  }
  \addlyrics
  { 
    \repeat unfold 6 \skip4
    \retrait "lui-même dans" la lu -- mière,
    \set shortVocalName = \markup\right-align"4." 
    "Nous sommes en commu" -- "nion les uns a" -- vec les autres,
    "et le Sang de Jésus son" "Fils nous purifie de" tout pé -- ché.
  }
  \addlyrics
  { 
    \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
    "Dès maintenant ' nous" "sommes en" -- fants de Dieu,
    "et ce que nous se" -- "rons n’a pas encore été ma" -- ni -- fes -- té.
    "Lors de cette manifesta" -- "tion, nous lui se" -- rons sem -- blables,
    "parce que nous le ver" -- rons tel qu’il est.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = "6." \set shortVocalName = \markup\right-align"6." 
    "Jean est venu rendre témoi" -- "gnage à" la Lu -- mière,
    "et le Verbe de Vie a bril" -- "lé dans" nos té -- nèbres_:
    "à tous cex qui l’ont acceuil" -- "li et qui croient" en son Nom,
    "il a donné le pou" -- "voir de devenir en" -- fants de Dieu.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = "7." \set shortVocalName = \markup\right-align"7." 
    "Gloire au Père dont la" "voix retentit" en nos cœurs.
    "Gloire au" "Christ qui est venu habiter" par -- mi nous.
    "Gloire à l’Es" -- "prit qui nous revêt de" sa lu -- mière.
    "Trinité bienheu" -- reuse, gloire à toi_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = "8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIdh }
>>