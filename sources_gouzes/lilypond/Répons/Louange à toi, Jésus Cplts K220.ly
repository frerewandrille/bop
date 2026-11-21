\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key d \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIcf }

  \addlyrics
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Seigneur, je t’en" "prie, ' fais-moi voir" ta face_!
    "Et Dieu dit : “Je te ca" -- che -- "rai '" "dans la fente" du ro -- cher,
    "et je poserai ma" main sur toi_;
    "mais ma face, ' on ne peut la voir" sans mou -- rir_!”
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Voici que Moïse et É" -- "lie, ' apparus dans" la gloire,
    "s’entretenaient a" -- vec lui_' "de son exode à Jé" -- ru -- sa -- lem_;
    "car le Fils de l’homme sera livré" aux bour -- reaux,
    "il sera mis mort, ' mais le troisième jour il ressus" -- ci -- te -- ra_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Jésus prit avec" "lui ' Pierre, Jacques, et Jean" son frère,
    "Il les em" -- me -- na_’ "sur une hau" -- te mon -- tagne,
    "Et, tandis qu’il priait, ' il fut transfiguré" de -- vant eux,
    "Et ses vêtements devinrent blancs ’ com" -- me la neige.
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Dieu, ' per " -- "sonne ne l’a ja" -- mais vu,
    "Mais le Fils qui est "
  }
  \addlyrics
  { 
    \set shortVocalName = "4." 
    \repeat unfold 4 \skip4
    \retrait "dans le sein" du Père,_' "lui, nous l’a" ré -- vé -- lé.
    "Et nous avons vu la gloire qu’il tient" de son Père
    "comme Fils unique ' plein de grâce et de" vé -- ri -- té.
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Voici qu’une nu" -- "ée les couvrit de" son ombre,
    "et que" du ciel_' "la voix du Père se" fit en -- tendre_:
    "“Celui-ci est mon Fils bien-aimé, é" -- cou -- tez_- le_!”
    "Seigneur, dans ta lumière, nous avons vu" la lu -- mière !
  }
  \addlyrics
  { 
    \set stanza = #"6. " \set shortVocalName = "6." 
    "Nous tous qui, le visage décou" -- 
    "vert, réfléchissons comme "
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
  { 
    \set shortVocalName = "6." 
    \skip4 \ptretrait "en un miroir la gloire du" Sei -- gneur,
    "nous sommes trans" -- for -- més_' "de gloire en gloire ' en cette" même i -- mage,
    "pour faire resplendir la connaissance de la gloi"  -- re de Dieu,
    qui est sur la face du Christ.
  }
  \addlyrics
  { 
    \set stanza = #"7. " \set shortVocalName = "7." 
    "Gloire à Dieu ’ dont la" "voix a retenti du haut" des cieux.
    "Gloire au Fils bien-" ai -- mé_' "en qui le Père a mis tout" son a -- mour.
    "Gloire à l’Esprit ' qui prend les apôtres dans une nuée" de lu -- mière.
    "Aux trois, louange et gloire ' pour les siè" -- cles sans fin.
  }
  \addlyrics\with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8. " \set shortVocalName = "8." 
    "La nuée de l’Es" -- "prit a couvert la Vierge de" son ombre,
    "et Dieu a façonné" en elle_' "la chair du" Bien_- Ai -- mé_;
    "la nuée de l’Esprit a recouvert le Christ en" son e -- xode,
    "et Dieu a façonné de sa chair son Église" bien_- ai -- mée.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIch }
>>