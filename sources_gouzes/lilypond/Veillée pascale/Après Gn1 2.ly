\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key g \minor \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait
voy = \once \override LyricText.X-offset = #center-on-vowel

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
  { \armure \cadenzaOn \tonRIIkf
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Oui, elle est droite, la parole" du Sei -- gneur
    "il est fidèle en tout" ce qu’il fait.
    "Il aime le bon droit et" la jus -- tice
    "la terre est remplie de" son a -- mour.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Le Seigneur a fait les cieux par" sa pa -- role,
    \voy "l’univers, par le souffle" de sa bouche.
    "Il amasse, il retient" l’eau des mers,
    "les océans, il les garde" en ré -- serve.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Heureux le peuple dont le Seigneur" est le Dieu,
    "heureuse la nation qu’il s’est choisie" pour do -- maine_!
    "Du haut des cieux, le Sei" -- gneur re -- garde_:
    "il voit la ra" -- ce des hommes.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Nous attendons notre vie" du Sei -- gneur_:
    "il est pour nous un appui, un" bou -- cli -- er.
    "Que ton amour, Seigneur," soit sur nous
    "comme notre espoir" est en toi_!
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIkh
  }
>>