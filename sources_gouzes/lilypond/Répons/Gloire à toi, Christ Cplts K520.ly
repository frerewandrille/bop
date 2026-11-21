\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key d \minor \time 3/4 }

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
  { \armure \cadenzaOn \tonRVIff }

  \addlyrics
  { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    La -- zare_! Viens de -- hors!
    "Je t’appelle, ' et" "toi, tu" me ré -- ponds.
    "Éveille-toi, ô toi qui dors ! ’ Relève -" "toi d’en" -- tre les morts_!
    "Je suis la résurrec" -- "tion et la vie" é -- ter -- nelle_!
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Toi qui as fait sur"gir du tom -- beau
    "Lazare enseve" -- "li depuis" qua -- tre jours,
    "Tu as visi" -- "té le domai" -- ne des morts
    "Pour qu’ils voient la lumi" -- "ère et contemplent" ton vi -- sage.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" Dox. " \set shortVocalName = \markup\right-align"3." 
    "Gloire au Père qui a ressuscité Jé" -- "sus d’en" -- tre les morts
    "Et qui lui a don" -- "né de disposer" de la Vie.
    "Gloire au Fils qui ouvre nos tom" -- "beaux et met en nous" son Es -- prit.
    "Gloire à l’Esprit qui habite en nos" "corps et leur don" -- ne la Vie.
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    
  }
  \addlyrics
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIfh }
>>