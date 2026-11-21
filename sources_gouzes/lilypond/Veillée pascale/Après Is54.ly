\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key d \minor \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  {  \key f \major \cadenzaOn \transpose e g \tonRIIff
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Quand j’ai crié vers" "toi, Sei" -- gneur,
    mon "Dieu, tu m’as gué" -- ri
    "Seigneur, tu m’as fait remonter de l’a" -- bîme
    "et revivre quand je descen" -- "dais à la" fosse.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Fêtez le Sei" -- "gneur, vous, ses fi" -- dèles,
    "rendez grâce en rappe" -- "lant son nom très" saint.
    "Sa colère ne dure qu’un ins" -- tant,
    "sa bon" -- "té, toute la" vie.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Avec le soir," "viennent les" larmes,
    "mais au ma" -- "tin, les cris de" joie.
    "Tu as changé mon deuil en une" danse,
    "mes habits funèbres en pa" -- "rure de" joie.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Que mon cœur ne se" taise pas,
    "qu’il soit en" "fête pour" toi,
    "et que sans fin, Seigneur, mon" Dieu,
    "je te" rende grâce_!
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Tu les amènes, tu les plantes sur la mon" -- "tagne, ton héri" -- tage,
    "le lieu que tu as fait, Sei" -- "gneur, pour l’habi" -- ter,
    "le sanctuaire, Seigneur, fondé par tes" mains.
    "Le Seigneur régnera pour les" "siècles des" siècles.
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \key f \major \cadenzaOn \transpose e g \tonRIIfh
  }
>>