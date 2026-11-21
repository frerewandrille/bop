\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key a \major }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose e d
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIIof }

\addlyrics
   { 
    \set stanza = #"Lu (1.) " \set shortVocalName = \markup\right-align"1." 
    "Ô Roi des" "saints, ' voici que se lève" la lu -- mière
    "sur l’immense foule, '" "fruit de" ta vic -- toire,
    "lorsque les eaux" saintes du bap -- tême
    "rendent la" "joie ' aux âmes" pu -- ri -- fiées.
   }
  \addlyrics
   { 
    \set stanza = #"Ma (2.) " \set shortVocalName = \markup\right-align"2." 
    "Un peuple saint re" -- "naît de l’eau et" de l’Es -- prit,
    "lavé du vieux pé" -- "ché ' dans le fleu" -- ve nou -- veau_;
    "le vêtement nou" -- "veau ' rayonne" la lu -- mière,
    "la blancheur du trou" -- "peau ' réjouit" le Pas -- teur.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Me (3.) " \set shortVocalName = \markup\right-align"3." 
    "Ton Église te" "loue, ' ô Christ" no -- tre Dieu,
    "toi qui, par ta" "mort ' l’as prise" pour é -- pouse_;
    "par ton sang répan" -- "du, ' tu écri" -- vis sa dot,
    "et ton amour s’é" -- "tend ' pour les siè" -- les des siècles.
  }
  \addlyrics
   { 
    \set stanza = #"Je (4.) " \set shortVocalName = \markup\right-align"4." 
    "Invités au banquet du" "Fils, ' le libérateur de" l’u -- ni -- vers,
    "nous étions dans la" "mort ' et nous sommes appelés" à la Vie_:
    "purifions -" "nous ' dans le sang" de l’A -- gneau,
    "à la louange de" gloire de sa grâce.
  }
  \addlyrics
   { 
    \set stanza = #"Ve (5.) " \set shortVocalName = \markup\right-align"5." 
    "Premiers-nés, fils de l’É" -- "glise, ' voyons dans" le mys -- tère
    "la gloire du" "Fils ' qui nous appelle à" la lu -- mière.
    "L’amour d’en-haut est descen" -- "du ' et nous don" -- ne la Vie,
    "pour que nous proclamions la" sainte -- té de Dieu.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Sa (6.) " \set shortVocalName = \markup\right-align"6." 
    "Nous n’étions “Pas un" "peuple” et “Sans mi" -- sé -- ri -- "corde”,"
    "mais il nous a ai" -- "més ' et nous som" -- mes à lui_:
    "appelés des té" -- "nèbres ' à sa dou" -- ce lu -- mière,
    "annonçons ses louanges à la" gloire de son Nom.
  }
  \addlyrics
   { 
    \set stanza = #"Dox (7.) " \set shortVocalName = \markup\right-align"7." 
    "Gloire à toi, Père saint,"
  }
  \addlyrics
   { 
    \set shortVocalName = \markup\right-align"7." 
    \retrait "qui as ressusci" -- "té Jésus d’en" -- tre les morts,
    "gloire à toi, Seigneur" "Christ, ' qui nous as sauvés" de la mort,
    "gloire àtoi, Esprit -" "Saint, ' qui nous don" -- nes la Vie.
    "Trinité bienheu" -- reuse,_' gloire à toi_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #" Magn (8.) " \set shortVocalName = \markup\right-align"8." 
   "Réjouis-toi, Ma" -- "rie, ' chante la gloire" de ton Fils,
   "Réjouis-toi, Église du Sei" -- "gneur, ' chante la gloire de" ton É -- poux_:
   "par sa résurrection, ' l’em" -- "pire de la mort" est dé -- truit.
   "Adam et ses enfants ' hé" -- "ritent du Royau" -- me nou -- veau.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIoh }
>>