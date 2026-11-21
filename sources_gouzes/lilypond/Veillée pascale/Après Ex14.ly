\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 2/4 }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}


\transpose e d
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }{ \key e \minor \cadenzaOn \tonRIef }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Je chanterai pour" le Sei -- gneur_!
    "Éclatante" est sa gloire_:
    "il a jeté dans" la mer
    "cheval et" ca -- va -- lier.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Ma force et mon chant, c’est" le Sei -- gneur_:
    "il est pour moi" le sa -- lut.
    "Il est mon Dieu, je le" cé -- lèbre_;
    "j’exalte le Dieu" de mon père.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Le Seigneur est le guerrier" des com -- bats_;
    "son nom est" "“Le" Sei -- "gneur”."
    "Les chars du Pharaon et ses armées, il les lance dans " la mer.
    "L’élite de leurs chefs a sombré dans" la mer Rouge.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    L’abîme les re -- couvre_:
    "ils descendent, comme la pierre, au" fond des eaux.
    "Ta droite, Seigneur, magnifique en" sa force,
    "ta droite, Seigneur, écrase" l’en -- ne -- mi.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Tu les amènes, tu les plantes sur la montagne, ton" hé -- ri -- tage,
    "le lieu que tu as fait, Seigneur, pour" l’ha -- bi -- ter,
    "le sanctuaire, Seigneur, fondé par" tes mains.
    "Le Seigneur régnera pour les siè" -- cles des siècles.
  }
  \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \key e \minor \cadenzaOn \tonRIeh }
>>