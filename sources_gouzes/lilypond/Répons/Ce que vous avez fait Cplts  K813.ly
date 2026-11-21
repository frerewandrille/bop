\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17) indent = 0

armure = { \key d \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 6
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIjf }

  \addlyrics 
  { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    "Quand Dieu vit l’homme tombé sous les coups de" l’En -- ne -- mi,
    "gisant à demi -" "mort sur le bord" du che -- min,
    "ému de compassion, ' il s’est penché" vers lui,
    "il a versé sur ses bles" -- "sures le baume de son" Es -- prit Saint.
  }
  \addlyrics 
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Le Christ s’est fait notre prochain : ' il nous a fait mi" -- sé -- ri -- corde,
    "il vient nous déli" -- "vrer du joug de" nos pé -- chés_;
    "il partage son Corps et son Sang à ceux qui en" ont faim,
    "il revêt de son a" -- "mour l’homme qui est sa" pro -- pre chair.
  }
  \addlyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    "Le Christ vient nous donner l’héritage de la vie" é -- ter -- nelle_;
    "aimons-nous les uns les" "autres comme il nous" a ai -- més_:
    "il nous a rendus proches par le sang de" sa croix,
    "et, par ses bles" -- "sures, nous avons connu" son a -- mour.
  }
  \addlyrics 
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    "Soyez saints, car moi, votre Dieu," je suis saint_!
    "Demeurez en mon a" -- "mour, car je suis" le Sei -- gneur_!
    "Aimez vos ennemis et ceux qui vous per" -- sé -- cutent,
    "et vous serez les" "fils de votre Père qui" est aux cieux.
  }
  \addlyrics 
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    "Soyez parfaits comme votre Père céleste" est par -- fait_:
    "le soleil de sa grâce se" "lève sur les bons et" les mé -- chants_;
    "dans son amour, ' il a voulu se réconcilier tous" les hommes,
    "quand son Fils fut immo" -- "lé sur l’autel" de la croix.
  }
  \addlyrics 
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    "Le Christ vous a pardonné : ' pardonnez," vous aus -- si_!
    "Il a effacé par son" "sang la dette de vo" -- tre pé -- ché_;
    "pardonnez à vos frères du fond de vo" -- tre cœur,
    "témoins de la miséri" -- "corde que vous a" -- vez re -- çue.
  }
  \addlyrics 
    { 
   \repeat unfold 9 {\skip4 }
    \set shortVocalName = \markup\right-align"7." 
     "nous avons été rachetés '"
  }
  \addlyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    "Pardonne-nous nos offenses, Dieu" no -- tre Père,
    "comme nous pardonnons aus" -- "si à ceux qui nous ont" of -- fen -- sés_;
    \set shortVocalName = "" 
    \retrait "par un sang plus précieux que celui" d’A -- bel,
    \set shortVocalName = \markup\right-align"7." 
    "par le sang de Jé" -- "sus, médiateur d’une allian" -- ce nou -- velle.
  }
  \addlyrics 
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" Dox. " \set shortVocalName = \markup\right-align"Dox." 
    "Béni soit Dieu qui nous a aimés ' dès avant la fonda" -- tion du monde,
    "béni soit Jésus" "Christ, le Fils de" son a -- mour,
    "béni soit l’Esprit Saint ' qui nous rassemble en un" seul peuple
    "et répand dans nos" "cœurs son amour" et sa paix_! 
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIjh }
>>