\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key g \major \time 3/4 }

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
  { \armure \cadenzaOn \tonRVIlf }

\addlyrics
   { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Je m’en vais vers mon Père et" vo -- tre Père,
    "vers mon Dieu et" vo -- tre Dieu.
    "Je ne vous laisserai pas" or -- phe -- lins.
    "Je m’en" "vais ' et je re" -- viens à vous.
   }
%   \addlyrics
%    { 
%     \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
%     "Comme vous avez vu le Christ ' s’élever" vers le ciel,
%     "ainsi vous le verrez revenir" dans la gloire.
%     "Encore un peu de temps ' et vous le" re -- ver -- rez
%     "quand il viendra ju" -- "ger ' les vivants" et les morts.
%   }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    
  }
  \addlyrics
   { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #" (Dox.) 5." \set shortVocalName = \markup\right-align"5." 
    "Gloire à toi, ô Christ, ' qui montes" du dé -- sert,
    "appuyé sur l’Église, ' ton Épouse" bien_- ai -- mée.
    "Gloire au Père qui t’a réveillé ' et te fait siéger" à sa droite_!
    "Gloire à l’Esprit d’a" -- "mour, ' le vainqueur" de la mort_!
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
  { \clef "bass" \armure \cadenzaOn \tonRVIlh }
>>