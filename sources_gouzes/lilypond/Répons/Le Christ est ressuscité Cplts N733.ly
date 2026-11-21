\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key g \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait

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
  { \armure \cadenzaOn \tonRVIkf }

\addlyrics
   { 
    \set stanza = #"Lu (1.)" \set shortVocalName = \markup\right-align"1." 
    "Aujourd’hui s’accomplit la Pâque" du Sei -- gneur,
    "et Dieu pose en Sion ' une" "pierre angu" -- laire.
    "La pierre que les bâtis" -- "seurs ' avaient" re -- je -- tée
    "est devenue la tête d’angle ' du Temple non" fait de main d’homme.
   }
  \addlyrics
   { 
    \set stanza = #"Ma (2.)" \set shortVocalName = \markup\right-align"2." 
    "Aujourd’hui s’accomplit la Pâque" du Mes -- sie_:
    "voici la demeure de" "Dieu ' parmi les" hommes.
    "Christ est ressuscité, ' l’Emmanu" -- "el, ' Dieu" a -- vec nous,
    "et nous sommes son Temple, ' les" membres de son Corps.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Me (3.)" \set shortVocalName = \markup\right-align"3." 
    "Aujourd’hui s’accomplit la Pâque" du Sau -- veur_:
    "le Fils de l’Homme es glorifié ' et Dieu est glori" -- "fié en" lui.
    "En sa résurrection, ' tout l’uni" -- "vers se" ré -- jou -- it_:
    "voici qu’il a fait toutes" cho -- ses nou -- velles.
  }
  \addlyrics
   { 
    \set stanza = #"Je (4.)" \set shortVocalName = \markup\right-align"4." 
    "Aujourd’hui s’accomplit la Pâque du Fils" bien_- ai -- mé_:
    "il donne à ses disciples ' un commande" -- "ment nou" -- veau_:
    "“Aimez-vous les uns les autres ' comme" "je vous" ai ai -- més_;
    "demeurez en moi ' et je de" -- meure -- rai en "vous ;”"
  }
  \addlyrics
   { 
    \set stanza = #"Ve (5.)" \set shortVocalName = \markup\right-align"5." 
    "Aujourd’hui s’accomplit la Pâque" du Roy -- aume_:
    "le Christ est le Chemin, la Véri" -- "té, la" Vie.
    "Il s’en va vers le Père ' et nous pré" -- "pare u" -- ne de -- meure,
    "il nous appelle des ténèbres ' à son admi" -- ra -- ble lu -- mière.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Sa (6.)" \set shortVocalName = \markup\right-align"6." 
    "Aujourd’hui s’accomplit la Pâque" de l’É -- glise_:
    "il fait de nous son peuple ' et nous ras" -- "semble en son a" -- mour.
    "Nous sommes une race chosie, ' un sacer" -- do -- ce roy -- al,
    "les pierres vivantes ' de son" "Corps res" -- sus -- ci -- té.
  }
  \addlyrics
   { 
    \set stanza = #"Dox (7.)" \set shortVocalName = \markup\right-align"7." 
    "Aujourd’hui s’accomplit la Pâque du Dieu" trois fois Saint_:
    "chantons le Père ' qui a ressuscité Jé" -- "sus d’entre les" morts_;
    "chantons le Christ ' qui a brisé les" portes de la mort_;
    "chantons l’Esprit ' qui nous con" -- duit à la Vie_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #" Magn (8.)" \set shortVocalName = \markup\right-align"8." 
    "Aujourd’hui s’accomplit la Pâque" de la Croix_:
    "Jésus fait de Marie ' la" "Mère des croy" -- ants_:
    "elle console ses enfants ' de" toutes leurs é -- preuves
    "et les conduit aux" noces de son Fils.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIkh }
>>