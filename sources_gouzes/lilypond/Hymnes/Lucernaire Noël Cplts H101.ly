\version "2.24.0"

\include "TonsRDef.ly"
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
  { \armure \cadenzaOn \tonRVIof }

  \addlyrics
  { 
    \set stanza = "1." \set shortVocalName = \markup\right-align"1." 
    "Venant au coucher" du so -- leil,
    "contemplant la lumière" du soir,
    "nous chantons le Père," et le Fils,
    "et le Saint-Es" -- prit de Dieu.

  }
  \addlyrics
  { 
    \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
    "Digne es-tu en tous temps d’ê" -- tre lou -- é
    "par de sain" -- tes voix,
    "Fils de Dieu qui don" -- na la vie,
    "et le monde te" glo -- ri -- fie.
  }
  \addlyrics
  { 
    \set stanza = "3." \set shortVocalName = \markup\right-align"3." 
    "Seigneur Jésus, nous" t’a -- do -- rons,
    "Image du Père in" -- vi -- sible,
    "Rayonnement de la Gloi" -- re d’en Haut,
    "Sagesse éternelle et Ver" -- be de Dieu.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
    "Béni sois-tu, Ange du" grand Des -- sein,
    "Premier-Né de toute cré" -- a -- ture,
    "Fils Bien-Aimé, Prince" de la Paix,
    "Père du monde" à ve -- nir.
  }
  \addlyrics
  { 
    \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
    "Nous t’acclamons et nous te" bé -- nis -- sons,
    "car tu as visité no" -- tre terre_;
    "La création se réjouit et s’incline" de -- vant toi,
    "elle t’offre la voix de" sa lou -- ange.
  }
  \addlyrics
  { 
    \set stanza = "6." \set shortVocalName = \markup\right-align"6." 
    "Les anges t’offrent leurs chants, et les mages" leurs pré -- sents,
    "les cieux t’offrent une étoile, et la terre u" -- ne grotte,
    "les bergers t’offrent un agneau, la race d’Ève of" -- fre Ma -- rie,
    "et Marie offre en sa chair ta demeure" par -- mi nous.
  }
  \addlyrics
  { 
    \set stanza = "7." \set shortVocalName = \markup\right-align"7." 
    "Tu viens apporter la Paix" sur la terre
    "aux hommes de bonne vo" -- lon -- té_;
    "en ta chair, tu viens ré" -- con -- ci -- lier
    "la terre avec le ciel, et l’homme" a -- vec Dieu.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = "8." \set shortVocalName = \markup\right-align"8." 
    "Que ma prière, vers" toi Sei -- gneur,
    "s’élève comme" l’en -- cens,
    "et mes mains," de -- vant toi,
    "comme l’offran" -- de du soir.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIoh }
>>