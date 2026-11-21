\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }
ptretrait = \once \override LyricText.X-offset = #4

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
  { \armure \cadenzaOn \tonRXbf }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Criez de joie pour le Seigneur, no" -- tre Force,
    "Acclamez le Dieu de" Ja -- cob_!
    "Que jaillisse le chant, battent les tam" -- bou -- rins_!
    "Que chantent doucement la ci" -- "thare et" la lyre_! 
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Criez de joie pour le Seigneur, no" -- tre Force,
    "Que sonne le cor au mois" nou -- veau_!
    "Qu’il sonne au jour de plei" -- ne lune,
    Au "jour de no" -- tre fête_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Car c’est là une loi pour Is" -- ra -- ël,
    "Une coutume en l’honneur du Dieu de" Ja -- cob,
    "Le signe qu’il a donné à la maison de" Jo -- seph,
    "Lui qui était parti vers la" terre d’É -- gypte.
  }
  \addlyrics
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Je reçois un oracle dans une langue in" -- con -- nue_;
    "Ouvre large ta bouche, je l’emplirai de ma" Pa -- role_:
    "J’ai déchargé ton épaule du" far -- deau,
    "J’ai mis fin aux cor" -- "vées de" tes mains.
  }
  \addlyrics
  { 
    \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
    "Lorsque tu as crié vers moi dans la" dé -- tresse,
    "Je suis venu pour te" sau -- ver_;
    "Je t’ai répondu dans le secret de la" tem -- pête,
    "Je t’ai mis à l’é" -- "preuve aux sources de Mé" -- ri -- ba.
  }
  \addlyrics
  { 
    \set stanza = #"6." \set shortVocalName = \markup\right-align"6." 
    \repeat unfold 9 \skip4
    "C’est moi le Seigneur qui suis ton" "Dieu, ' moi qui t’ai fait"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"6." \set shortVocalName = \markup\right-align"6." 
    "Écoute, ô mon Peuple, je témoigne de" -- vant toi_:
    "Ô Israël, si tu voulais m’é" -- cou -- ter_!
    "Qu’il n’y ait pas chez toi d’autre dieu, ' ne va pas adorer un dieu é" -- tran -- ger_!
    \set shortVocalName = \markup\right-align"" \skip4
    \ptretrait "monter de la terre" d’É -- gypte.
  }
  \addlyrics
  { 
    \set stanza = #"7." \set shortVocalName = \markup\right-align"7." 
    "Mais mon peuple n’a pas écouté" ma voix,
    "Israël ne s’est pas donné" à moi,
    "Je les ai livrés à la dureté de" leur cœur.
    "Ils s’en allaient, ' ne sui" -- "vant que leurs" des -- seins.
  }
  \addlyrics
  { 
    \set stanza = #"8." \set shortVocalName = \markup\right-align"8." 
    "Ah ! si mon peuple m’é" -- cou -- tait,
    "Si Israël marchait dans mes" che -- mins,
    "En un instant, j’abattrais ses ad" -- ver -- saires,
    "Et sur ses oppres" -- "seurs, ' je ferais peser" ma main.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"9." \set shortVocalName = \markup\right-align"9." 
    "Les ennemis du Seigneur s’inclineraient de" -- vant lui,
    "Leur épouvante durerait à" ja -- mais,
    "Je nourrirais mon peuple d’un froment de" dé -- lices,
    "Et du miel du ro" -- "cher, ' je le rassa" -- sie -- rais.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRXbh }
>>