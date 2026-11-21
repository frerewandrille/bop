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
  {  \key f \major \cadenzaOn \tonRVIgf
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Voici le" Dieu qui me sauve_:
    "j’ai con" -- "fiance,  je n’ai" plus de crainte.
    "Ma force et mon" "chant, c’est" le Sei -- gneur_:
    "il est pour" moi le sa -- lut.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    Rendez grâce au Sei -- gneur,
    \skip4 procla -- mez son nom,
    "annoncez parmi les" peuples ses hauts faits_!
    "Redites-le : « Sub" -- lime est son nom_!_»
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Jouez pour le Seigneur,  il montre" "sa ma" -- gni -- fi -- cence,
    "et toute la" ter -- re le sait.
    "Jubilez, criez de joie, habi" -- tants de Si -- on,
    "car il est grand au milieu de toi, le" Saint d’I -- sra -- ël_!
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \key f \major \cadenzaOn \tonRVIgh
  }
>>