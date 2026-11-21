\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait

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
  { \armure \cadenzaOn \tonRIIIbf }

\addlyrics
   { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    
   }
  \addlyrics
   { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    
  }
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
  { \clef "bass" \armure \cadenzaOn \tonRIIIbh }
>>