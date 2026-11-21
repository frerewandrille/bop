\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key f \major }

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
  { \armure \cadenzaOn \tonRVIgf }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Dans ton peuple, Seigneur Jé" -- "sus, ' Dominique s’est levé" comme un feu_:
    "Il a brûlé d’a" -- "mour pour le sa" -- lut des hommes.
    "Jour et nuit, il a médi" -- té ta Pa -- role,
    "Sur son vi" -- "sage, ta lumière a" res -- plen -- di.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Son souvenir est un parfum d’en" -- "cens pour ceux qui l’aiment et" l’ont sui -- vi,
    "Sa mémoire est comme une mu" -- "sique au milieu" d’un fes -- tin.
    "Sans cesse, il a gardé son" "cœur tour" -- né vers toi.
    "Tu l’as choisi pour veiller à l’accomplisse" -- "ment de" ta Pa -- role.
  }
  \addlyrics
  %\with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Tu l’as rendu magni" -- "fique par les dons de" ton Es -- prit,
    "Comme l’étoile du ma" -- "tin au milieu" des nu -- ages,
    "Comme un oli" -- "vier char" -- gé de fruits,
    "Debout dans sa mai" -- "son, entouré d’une couron" -- ne de frères.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Il a aimé la beau" -- "té de" ta mai -- son,
    "Il a été le gardien vigi" -- lant de ta vigne.
    "Jubilant, il a veil" -- "lé sur" ton trou -- peau,
    "Tu as fait de lui une pierre vi" -- vante de ton temple.
  }
  \addlyrics
  { 
    \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
    
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
    \set stanza = #"Dox." \set shortVocalName = \markup\right-align"8." 
    "Gloire au Père qui nous a don" -- né sa Pa -- role,
    "Gloire au Fils u" -- "nique, notre roc et no" -- tre rem -- part,
    "Gloire à l’Esprit qui a rem" -- "pli le cœur de" Do -- mi -- nique,
    "Trinité bienheureuse, repos de tous les" saints, gloire à Toi_!
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIgh }
>>