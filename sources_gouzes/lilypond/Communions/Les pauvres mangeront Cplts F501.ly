\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose bes g
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIIdf }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Le Seigneur est mon ber" -- ger,
    "je ne" "manque de" rien.
    "Sur des prés d’herbe" fraîche,
    "il me" fait re -- po -- ser.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Il me conduit vers les eaux tran" -- quilles.
    "Il y fait re" -- "vivre mon" âme.
    "Il me guide par les sentiers du sa" -- lut,
    "pour la" gloire de son Nom.
  }
  \addlyrics
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Et si je dois franchir la vallée des té" -- nèbres,
    "je ne crains aucun mal, car tu" "es près de" moi.
    "Ton bâton est là qui me pro" -- tège, 
    "et ta hou" -- lette me ras -- sure.
  }
  \addlyrics
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Devant moi tu prépares une" table
    "sous les yeux de" "ceux qui me pour" -- suivent.
    "Tu répands sur ma tête un parfum de" joie,
    "et ma" cou -- pe dé -- borde.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
    "La grâce et le bonheur m’accom" -- pagnent
    "tous les" "jours de ma" vie_;
    "J’ai ma demeure dans la maison de" Dieu
    "pour ces jours qui n’au" -- ront pas de fin.
  }
  \addlyrics
  { 
    \set stanza = #"6." \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = #"7." \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIdh }
>>