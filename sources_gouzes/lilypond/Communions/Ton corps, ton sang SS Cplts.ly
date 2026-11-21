\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 5.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIIcf }
  
  \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Grand Prêtre de l’alliance nou" -- velle,
    "tu as offert le sacri" -- "fice sur l’autel" de la croix.
    "Tu te livres en donnant le pain" et le vin,
    "tu nourris l’Église par ton Corps" et ton Sang.
  }
  
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Banquet pascal où nous te recevons en nourri" -- ture,
    "mémorial où ta pas" -- "sion est" cé -- lé -- brée,
    "où notre âme est remplie" de ta grâce,
    "où la gloire à venir nous est dé" -- jà don -- née.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Fêtons la Pâque en mangeant le pain du" ciel_!
    "Ta Chair ressusci" -- "tée nous arrache" à la mort,
    "et ton Sang coule en nous comme un fleu"  -- ve de vie
    "qui réjouit l'Église ton Épouse" bien_- ai -- mée.
  }
  
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" Dox." \set shortVocalName = \markup\right-align"Dox." 
    "Rendons gloire à ton Père, de qui vient tout don par" -- fait_!
    "Gloire à toi, Fils unique, ' ve" -- "nu dans" no -- tre chair_!
    "Tu nous as rachetés de la mort par ton Corps" et ton Sang,
    "et ton Église jubile de la vie" de l’Es -- prit_!
  }
  
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIch }
>>