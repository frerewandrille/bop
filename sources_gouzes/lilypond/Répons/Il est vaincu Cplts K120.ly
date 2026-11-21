\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key f \minor \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose aes g
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIIef }

  \addlyrics
  { 
    \set stanza = "1." \set shortVocalName = \markup\right-align"1." 
    "Jésus fut conduit au dé" -- "sert ' par" l’Es -- prit Saint
    "Et pendant quarante" "jours,' il lutta a" -- vec le diable.
    "Il délivre Adam de l’ex" -- "il ' et le ramène au pa" ra -- dis_:
    "“Voici. Je t’ai séduit et conduit au dé" -- "sert ' et je parle" à ton cœur.”
  }
  \addlyrics
  { 
    \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
    "“Adam, je t’ap" "pelle: '" Où es- tu_?
    "Tu me ré" "ponds comme aux jours de" ta jeu -- nesse_:
    "Je te fiancerai à" "moi ' dans la fidé" li -- té
    "Et tu connaîtras le" "Nom de" ton Sei -- gneur.”
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = " Dox." \set shortVocalName = \markup\right-align"D." 
    "Gloire au Père très" "bon ' qui nous délivre" de tout mal.
    "Gloire au Christ vain" -- "queur ' qui a combattu dans" le dé -- sert.
    "Gloire à l’Esprit de véri" -- "té ' qui triomphe du" men -- songe.
    "Que le nom du Dieu très-" "haut soit" sanc -- ti -- fié.
  }
  \addlyrics
  { 
    \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
    
  }
  \addlyrics
  { 
    \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
    
  }
  \addlyrics
  { 
    \set stanza = "6." \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = "7." \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = "8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIeh }
>>