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
  { \armure \cadenzaOn \tonRVIqf }

  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = 4 }
  { 
    \set stanza = "(I V) 1." \set shortVocalName = \markup\right-align"1." 
    "Voici qu’il vient, ' le Sei" -- "gneur que vous cher" -- chez,
    "le Messager de l’Alliance, ' désiré des col" -- "lines éternel" -- les.
    "Il vient purifier le" "cœur de son" peuple,
    "et Dieu accueillera l’of" -- "frande de Jérusa" -- lem.
  }
  \addlyrics
  { 
    \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
    "Voici que le Sei" -- "gneur vient dans son" Temple,
    "réjouis-toi, Jérusalem, ' à la ren" -- "contre de ton" Dieu_!
    "Prépare, ô Sion, ' la" "chambre nup" -- tiale,
    "reçois Marie, Porte du ciel, ' et Trône du" "Roi de" Gloire_!
  }
  \addlyrics
  { 
    \set stanza = "3." \set shortVocalName = \markup\right-align"3." 
    "La Vierge est bai" -- "gnée de lumi" -- ère,
    "elle porte son fils, ' à la ren" -- "contre de ton" Dieu_!
    "Voici l’Arche d’Alliance, ' et la Nu" -- "ée lumi" -- neuse,
    "Dieu est avec vous, ' car éter" -- "nel est son a" -- mour_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = 4 }
  { 
    \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
    "Siméon et Anne veil" -- "laient dans le" Temple,
    "ils attendaient la consola" -- "tion d’Isra" -- ël_;
    "Au milieu de la nuit, ' ils ont recon" -- "nu la Lu" -- mière,
    "et leurs yeux ont vu le Sa" -- "lut de" Dieu_!
  }
  \addlyrics
  { 
    \set stanza = "(L) 5." \set shortVocalName = \markup\right-align"5." 
    "Jésus, Lumière qui é" -- "claire tout" homme,
    "Jésus, Temple véritable, ' qui viens au de" -- "vant des croy" -- ants,
    "Jésus, Agneau immo" -- "lé et Grand" Prêtre,
    "nous Te glorifions avec ceux qui ont espé" -- "ré voir ton" Jour.
  }
  \addlyrics
  { 
    \set stanza = "(II V) 6." 
    "L’Esprit lui ayant révélé '"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = 4 }
  { 
    \retrait"qu’il ne verrait" "pas la" mort,
    \set shortVocalName = \markup\right-align"6." 
    "avant d’avoir vu le" "Christ du Sei" -- gneur,
    "Siméon reçoit dans ses bras le Sau" -- "veur du" monde_:
    "“Tu peux laisser ton serviteur ' s’en al" -- "ler dans la" paix.”
  }
  \addlyrics
  { 
    \set stanza = "(Dox.) 7." \set shortVocalName = \markup\right-align"7." 
    "Gloire au Père qui a tout con" -- "çu dans son a" -- mour,
    "gloire au Seigneur Jésus, ' Lu" -- "mière des na" -- tions,
    "gloire à l’Esprit ' qui nous conduit à la ren" -- "contre du Sau" -- veur,
    "Trinité sainte qui nous sauves, '" "gloire à" toi_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = " (Magn.) 8." \set shortVocalName = \markup\right-align"8." 
    "Comme la lune reflète l’é" -- "clat du So" -- leil,
    "tu es revêtue, Mère de Dieu, ' de la Lu" -- "mière de ton" fils.
    "Un glaive de douleur transperce" -- "ra ton" âme,
    "Et du côté de ton Fils jailli" -- "ra le Sa" -- lut_!
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIqh }
>>