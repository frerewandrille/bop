\version "2.24.0"

\include "vowel-set.ly"

armure = { \key e \minor \time 3/4 }


<<
  \new Staff \with {\remove Time_signature_engraver } { 
    \key e \minor \cadenzaOn \voiceOne \relative c' 
    { e\breve c' d8 b2\breathe\allowBreak
      e,\breve c' e8_- [c] b2\fermata \bar"|"
      c8 [d] e\breve d8 [c d]  b2\breathe\allowBreak
      b\breve c e8 [c] b2\fermata } \bar"|."
  }
  \addlyrics
  { 
    \set stanza = #"Lu (1.)" \set shortVocalName = \markup\right-align"1." 
    Entends_- "moi, Seigneur ! ' je crie" vers toi_!
Pas "un qui" me con -- sole_!
Mon cœur "en moi se retourne. '" Vois mon an -- goisse_!
"Fais ve" -- "nir le jour que tu as" pro -- cla -- mé_!
  }
  \addlyrics
  { 
    \set stanza = #"Ma (2.)" \set shortVocalName = \markup\right-align"2." 
    Cri -- "ez vers le Seigneur, ' remparts de la sainte" Si -- on_!
"Jérusa" -- "lem, laisse couler tes larmes comme" un tor -- rent_!
Ré -- pands "ton cœur comme de l’eau ' devant la fa" -- ce du Sei -- gneur_!
De -- "bout _! ' Pousse un cri dans la nuit_! ' Élève vers" lui les mains_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"Me (3.)" \set shortVocalName = \markup\right-align"3." 
    Sei -- "gneur, souviens-toi de ma misère ' et du fiel de mon" an -- goisse_!
"Je me sou""viens ' et mon âme en" moi s’ef -- fondre_!
Mais au "matin, Seigneur, tu renouvel" -- les tes ten -- dresses.
Ma "part, c’est le Seigneur, ' en qui j’ai mis" mon es -- poir_!
  }
  \addlyrics
  { 
    \set stanza = #"Je (4.)" \set shortVocalName = \markup\right-align"4." 
    "Je ne" "donnerai point de répit à" mes yeux,
Et "point de trêve" à mes larmes,
A -- fin "que le Seigneur regarde du haut" de sa de -- meure
"Le mal""heur de la fille" de Si -- on
  }
  \addlyrics
  { 
    \set stanza = #"Ve (5.)" \set shortVocalName = \markup\right-align"5." 
    "Dans une" "fosse, ' ils ont précipité" ma vie.
Vers "toi, Seigneur, j’ai crié : ' Je" suis per -- du_!
J’ai in -- "voqué ton nom, Seigneur_! ' Écou" -- te mon ap -- pel_!
"Tu t’es fait" "proche ' et tu m’as dit :" Ne crains pas_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"Sa (6.)" \set shortVocalName = \markup\right-align"6." 
    Pour -- "quoi nous oublierais-tu pour" tou -- jours_?
Pour -- "quoi nous abandonnerais-tu jusqu’à la" fin des jours_?
Fais_- nous "revenir, Seigneur, ' et nous re" -- vien -- drons vers toi.
"Renouvelle nos" "jours, ' comme aux jours" d’au -- tre -- fois_!
  }
  \addlyrics
  { 
    \set stanza = #"Dox (7.)" \set shortVocalName = \markup\right-align"7." 
    "Gloire à" "toi, notre Père, ' qui es riche en" par -- don.
"Gloire à" "toi, Fils bien-aimé, ' qui nous as sauvés" de la mort.
Gloire à "toi, Esprit de sainteté," Con -- so -- la -- teur.
Trinité "sainte, ' louange et" gloire à toi_!
  }
>>