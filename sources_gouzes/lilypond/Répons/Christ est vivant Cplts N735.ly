\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }
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
  { \armure \cadenzaOn \tonRIInf }

\addlyrics
   { 
    \set stanza = #"Lu (1.) " \set shortVocalName = \markup\right-align"1." 
    "J’ai élevé les" "mains et me suis approché" du Sei -- gneur:
    "mes bras étendus ' sont le" signe de sa croix_;
    "je suis dressé vers lui ' comme le" "bois auquel il fut" pen -- du,
    "lui, le" "Juste, ' sur le bord" du che -- min.
   }
  \addlyrics
   { 
    \set stanza = #"Ma (2.) " \set shortVocalName = \markup\right-align"2." 
    "Toute la" "terre est une empreinte" de ta Pâque,
    "le mémorial éter" -- "nel de" son sa -- lut_:
    "le Christ nous a renouve" -- "lés ' par le vêtement de" sa grâce_:
    "Il a pris possession de nos" "cœurs ' par" sa lu -- mière.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Me (3.) " \set shortVocalName = \markup\right-align"3." 
    "Le Seigneur m’a fait quit" -- "té le chemin" de l’er -- reur,
    "par lui, mes yeux se sont ou" -- "verts ' et j’ai vu son" jour très saint.
    "Je suis allé vers" "lui ' et me suis ré" -- jou -- i,
    "sa beauté m’a recré" -- "é ' et revêtu" de sa grâce.
  }
  \addlyrics
   { 
    \set stanza = #"Je (4.) " \set shortVocalName = \markup\right-align"4." 
    "Le Seigneur m’a mon" -- "tré le signe" de sa croix,
    "Il m’a fait remon" -- "ter ' des profondeurs" des en -- fers,
    "il m’a arra" -- "ché ' à la gueule de" la mort,
    "il m’a conduit par sa lumière ' et exal" -- "té dans sa mi" -- sé -- ri -- corde.
  }
  \addlyrics
   { 
    \set stanza = #"Ve (5.) " \set shortVocalName = \markup\right-align"5." 
    "La joie a jailli dans le" "cœur des" bien -- heu -- reux_:
    "ma voix est montée vers le Sei" -- "gneur ' et il m’a" en -- ten -- du_;
    "et la Parole du Sei" -- "gneur ' est venue jus" -- \apostrophe qu’à moi,
    "me donnant le repos ' et les" "fruits de" mes tra -- vaux.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"Sa (6.) " \set shortVocalName = \markup\right-align"6." 
    "Le Seigneur m’a transpor" -- "té dans son" Pa -- ra -- dis,
    "et je devins comme une" "terre ' qui germe et" qui fleu -- rit.
    "Heureux, Seigneur, ' ceux qui sont plan" -- "tés dans ton" jar -- din_:
    "dans la douceur de ta ro" -- "sée, ' ils regor" -- gent de fruits.
  }
  \addlyrics
   { 
    \set stanza = #"Dox (7.) " \set shortVocalName = \markup\right-align"7." 
    "Glorifiez le Seigneur, ' revêtez -" "vous de" sa lu -- mière_!
    "Que votre chant mur" -- "mure ' la beau" té de Dieu.
    "Et votre" "cœur ' sera comme" le jour,
    "proclamant les louanges du" "Père, ' du Fils et" de l’Es -- prit_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #" Magn (8.) " \set shortVocalName = \markup\right-align"8." 
    "Comme le sein du" "Père a engen" -- dré le Fils,
    "le sein de la Vierge Ma" -- "rie ' nous a don" -- né la Vie.
    "Librement, elle a accep" -- "té ' d’être la Mère des" croy -- ants_;
    "quand l’Heure fut venue, ' elle nous a enfan" -- "tés ' en grande mi" -- sé -- ri -- corde.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIInh }
>>