\version "2.24.0"
\include "Exultet cmd M120.ly"


\new Staff \with {\remove Time_signature_engraver }
<< 
  \cadenzaOn \key f \major
  \new Voice = "melodie" \Mus-Intro
  \new Lyrics 
  %\with {\override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 7)) }
  \Texte-Intro
>>

\new Staff \with {\remove Time_signature_engraver }
<< 
  \cadenzaOn \key f \major
  \new Voice = "melodie" \Mus-dial
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  %\with {\override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 7)) }
  \Texte-dial
>>

\new Staff \with {\remove Time_signature_engraver }
<< 
  \cadenzaOn \key f \major
  \new Voice = "melodie" \Mus-corps
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  %\with {\override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 7)) }
  \Texte-corps
>>