\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key g \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVInf }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Bénis le Seigneur," ô mon âme,
    "Que tout mon être cé" -- "lèbre son Nom très" saint_!
    "Bénis le Seigneur," ô mon âme,
    N’oublie au -- "cun de" "ses bien" -- faits.
  }
  \addlyrics
  { 
    \set stanza = #"2a." \set shortVocalName = \markup\right-align"2b." 
    "Lui qui a pardonné tou" -- tes tes fautes,
    "Lui qui t’a guérie de" "toute mala" -- %die,
    \once \override LyricText.X-offset = #-1
    \markup { die, \magnify #1.75 { \char ##x2B8C } }
    \set shortVocalName = \markup\right-align"2." 
    %"Lui qui a racheté ta vie à l’abîme" de la mort
    %"Lui qui te couronne d’a" -- "mour et de ten" -- dresse
    "Lui qui comblera tes années" de bon -- heur
    "Pour que se renouvelle ta" jeu -- nesse comme l’aigle.
  }
  \addlyrics
  { 
    \set stanza = #"2c." \set shortVocalName = \markup\right-align"2d." 
    %"Lui qui a pardonné tou" -- tes tes fautes
    %"Lui qui t’a guérie de toute" ma -- la -- die,
    "Lui qui a racheté ta vie à l’abîme" de la mort,
    "Lui qui te couronne d’a" -- "mour et de ten" -- dresse.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Le Seigneur accomplit son œuvre" de sa -- lut_:
    "Il rend justice à" "tous les oppri" -- més.
    "À Moïse, il a révélé" ses che -- mins,
    "Aux enfants d’Israël, il" fit voir "ses mer" -- veilles.
  }
  \addlyrics
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Le Seigneur est tendresse" et pi -- tié,
    "lent à la co" -- "lère et plein d'a" -- mour.
    "Il ne fait pas durer sa querelle" à ja -- mais.
    "Il ne garde pas sa" co -- lère "pour tou" -- jours.
  }
  \addlyrics
  { 
    \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
    "Il n’agit pas envers nous se" -- lon nos fautes,
    "et ne nous rend" "pas selon nos of" -- fenses.
    "Comme le ciel s’élève au-dessus" de la terre,
    "fort est son amour pour" ce -- lui "qui l’a" -- dore.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"9." \set shortVocalName = \markup\right-align"9." 
    "Le Seigneur a fondé son trône" dans les cieux.
    "Son Royaume s’étend par" "tout l’uni" -- vers.
    "Bénissez le Seigneur, vous ses anges qui écou" -- tez sa voix,
    "Vous qui accomplissez sa" Pa -- role "avec puis" -- sance_!
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
  { \clef "bass" \armure \cadenzaOn \tonRVInh }
>>