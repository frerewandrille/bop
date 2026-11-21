\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key e \minor }
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
  {  \armure \cadenzaOn \transpose a g \tonRVIIaf
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "La loi du Sei" -- "gneur est" par -- faite,
    \skip4 "qui redon" -- ne vie
    "la charte du Sei" -- gneur est sûre,
    "qui rend" sages les simples.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Les préceptes du Sei" -- gneur sont droits,
    "ils réjou" -- issent le cœur_;
    "le commandement du Sei" -- "gneur est" lim -- pide,
    "il clari" -- "fie le" re -- gard.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "La crainte qu’il ins" -- pire est pure,
    "elle est" "là pour" tou -- jours_;
    "les décisions du Sei" -- gneur sont justes
    "et vrai" -- "ment é" -- qui -- tables_:
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Plus dési" -- rables que l’or,
    qu’une masse d’or fin,
    "plus savou" -- "reuses que" le miel
    qui "coule des" ra -- yons.
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \transpose a g \tonRVIIah
  }
>>