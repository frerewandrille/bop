\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key a \major \time 3/4 }
ptRetrait = \once \override LyricText.X-offset = #3

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
  { \armure \cadenzaOn \tonRVIIIef }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Dieu, toi mon Dieu, je te" "cherche dès l’au"rore,
    "mon âme a" soif de toi_!
    "Après toi languit" ma chair,
    "comme une terre aride, altérée" et sans eau.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Ainsi je viens te" "voir dans ton sanctu" -- aire_!
    "Je veux contempler ta puissance" et ta gloire,
    "Car ton amour est meilleur que" la vie,
    "que mes lèvres chantent" ta lou -- ange_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Je veux te bénir tout au" "long de ma" vie_!
    "Que j’élève les mains en invo" -- quant ton nom_!
    "Tu es comme un festin qui rassasie" mon âme,
    "joie sur mes lèvres, louange" en ma bouche.
  }
  \addlyrics
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Quand dans la nuit je me sou" -- "viens de" toi,
    "et que, durant les veilles, je" pense à toi,
    \set shortVocalName = \markup\right-align"4a." 
    "Seigneur, tu te fais mon" se -- %cours,
    \once \override LyricText.X-offset = #-2
    \markup { cours,  \magnify #1.75 {\raise #-1.5 \char ##x21A9 } }
    \set shortVocalName = \markup\right-align"4." 
    "près de toi, je me blottis, et tu me prends" dans ta main.
  }
  \addlyrics
  { 
    \repeat unfold 7 { \skip4 } \set shortVocalName = \markup\right-align"4b."
    \ptRetrait"j’en ai crié de joie à l’ombre de" tes ailes,
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
    "Mais ceux qui s’en prennent à ma vie," \repeat unfold 2 { \skip4 }
    "ils seront livrés au pouvoir de l’épée," \repeat unfold 3 { \skip4 }
    \set shortVocalName = \markup\right-align"5a." 
    "Mais que le Roi trouve sa joie dans le" Sei -- %gneur_!
    \once \override LyricText.X-offset = #-2.5
    \markup { gneur ;  \magnify #1.75 {\raise #-1.5 \char ##x21A9 } }
    \set shortVocalName = \markup\right-align"5." 
    "La bouche des menteurs se" -- ra fer -- mée.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    %\set shortVocalName = \markup\right-align"5." 
    \ptRetrait "qu’ils s’enfoncent dans les profon" -- "deurs de la" terre_;
    \retrait "ils deviendront la proie" des cha -- cals.\set shortVocalName = \markup\right-align"5b."
    \ptRetrait"lui qui invoque son Nom, il sera glo" -- ri -- fié_!
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIeh }
>>