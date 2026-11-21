\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

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
  { \armure \cadenzaOn \tonRXaf }

  \addlyrics
  { 
    \set stanza = #"Lu (1.)" \set shortVocalName = \markup\right-align"1." 
    "Voici que resplen" -- "dit la lumiè" -- re du Christ
    "et que se lève la pure lu" -- mière de l’Es -- prit,
    "voici que s’ouvrent pour" "nous les trésors" du ciel,
    "répandant la gloire du Sei" -- "gneur ' sur toute la" cré -- a -- tion.
  }
  \addlyrics
  { 
    \set stanza = #"Ma (2.)" \set shortVocalName = \markup\right-align"2." 
    "La gloire du Dieu vi" -- "vant rayonne sur" tous les hommes
    "et le monde reçoit cette lu" -- "mière à jamais" ray -- on -- nante.
    "Voici qu’un jour sans" "fin de lumière é" -- ter -- nelle
    "s’instaure pour nous" "tous qui croy" -- ons en lui.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"Me (3.)" \set shortVocalName = \markup\right-align"3." 
    "Ô Verbe, ami des" "hommes, ' tu retournes au" -- près du Père
    "et tout est accom" -- "pli des désirs" de ton cœur.
    "Conduis-nous vers la de" -- "meure que tu nous as pré" -- pa -- rée,
    "toi qui es le Che" -- "min, la Vérité" et la Vie.
  }
  \addlyrics
  { 
    \set stanza = #"Dox (4.)" \set shortVocalName = \markup\right-align"4." 
    "Nous te louons," "Père, ' de qui vient tout" don par -- fait,
    "nous te louons, ô Christ, ' qui nous prépares une" "place au" -- près du Père,
    "nous te louons, Esprit d’a" -- "mour ' que le Père a" pro -- mis.
    "Trinité bienheureuse, '"
  }
  \addlyrics
  { 
    \repeat unfold 14 \skip4
    \retrait "repos de tous les" "saints, ' nous" t’a -- do -- rons_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" Magn (5.)" \set shortVocalName = \markup\right-align"5." 
    "Au moment où le" "Christ s’éloigne" de ce monde,
    "il nous donne Ma" -- "rie pour être" no -- tre Mère,
    "il nous donne l’É" -- "glise qui fait de nous" son Corps,
    "il nous donne l’Es" -- "prit ' par qui nous sommes di" -- vi -- ni -- sés.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRXah }
>>