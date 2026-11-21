\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17)

armure = { \key bes \major \time 3/4 }
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
  { \armure \cadenzaOn \tonRIIIcf }

  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"1. (I V)" \set shortVocalName = "1." 
    
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    
  }
  \addlyrics
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    
  }
  \addlyrics
  { 
    \set stanza = #"5. (L)" \set shortVocalName = "5." 
    
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"6. (II V)" \set shortVocalName = "6." 
    
  }
  \addlyrics
  { 
    \set stanza = #" 7. (Dox.)" \set shortVocalName = "7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8. (Magn.)" \set shortVocalName = "8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIIch }
>>