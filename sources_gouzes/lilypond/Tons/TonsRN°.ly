\version "2.24.0"

\header { title = "Tons de psalmodie pour répons" composer = " " tagline = "" }
\layout { indent = 0\mm		
          ragged-right = ##t }
#(set-global-staff-size 16)

\include "TonsRDef.ly"

coupure = { \noBreak }
resp = { \breathe }

\markup { \fontsize #2 \bold "Ton I" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn  \key d \minor \tempo "a" \tonRIaf  \tempo "c" \tonRIcf 
    \tempo "d" \tonRIdf \tempo "f" \tonRIff \tempo "g" \tonRIgf
    \break\key g \minor \tempo "b" \tonRIbf
    \break\key e \minor \tempo "e" \tonRIef \tempo "h" \tonRIhf
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 	
    \cadenzaOn  \key d \minor \tonRIah \tonRIch \tonRIdh \tonRIfh \tonRIgh
    \key g \minor \tonRIbh
    \break\key e \minor \tonRIeh \tonRIhh
  }
>> 
\markup { \fontsize #2 \bold "Ton II" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn  \key g \minor \tempo "a" \tonRIIaf \tempo "b" \tonRIIbf 
    \tempo "c" \tonRIIcf \tempo "d" \tonRIIdf\tempo "j" \tonRIIjf
    \tempo "h" \tonRIIhf
    \tempo "i" \tonRIIif \tempo "k" \tonRIIkf \tempo "m" \tonRIImf
    \tempo "n" \tonRIInf \tempo "q" \tonRIIqf
    \break\key f \minor \tempo "e" \tonRIIef 
    \break\key e\minor \tempo "f" \tonRIIff \tempo "l" \tonRIIlf 
    \break\key fis\minor \tempo "g" \tonRIIgf \tempo "o" \tonRIIof
    \break\key a\minor \tempo "p" \tonRIIpf
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 	
    \cadenzaOn  \key g \minor \tonRIIah \tonRIIbh \tonRIIch \tonRIIdh  
    \tonRIIjh \tonRIIhh \tonRIIih \tonRIIkh \tonRIImh \tonRIInh \tonRIIqh
    \key f \minor \tonRIIeh
    \key e\minor \tonRIIfh \tonRIIlh
    \key fis\minor  \tonRIIgh \tonRIIoh
    \key a\minor \tonRIIph
  }
>> 
\markup { \fontsize #2 \bold "Ton III" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn \key e \minor \tempo "a" \tonRIIIaf \tempo "c" \tonRIIIcf 
    \break\key a \minor \tempo "b" \tonRIIIbf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 		
    \cadenzaOn \key e \minor \tonRIIIah \tonRIIIch
    \key a \minor \tonRIIIbh
  }
>> 
\markup { \fontsize #2 \bold "Ton IV" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} {
    \cadenzaOn \key a \minor \tempo "a" \tonRIVaf \tempo "d" \tonRIVdf 
    \break\key d \major \tempo "b" \tonRIVbf \tempo "c" \tonRIVcf  
    \break\key ees \major \tempo "e" \tonRIVef
  }
  \new Staff \with { \remove "Time_signature_engraver"} {
    \clef bass 		
    \cadenzaOn \key a \minor \tonRIVah \tonRIVdh 
    \key d \major \tonRIVbh \tonRIVch
    \key ees \major \tonRIVeh 
  }
>> 
\markup { \fontsize #2 \bold "Ton V" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn \key c \major \tempo "a" \tonRVaf \tempo "c" \tonRVcf 
    \break\key d \major \tempo "b" \tonRVbf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 	
    \cadenzaOn \key c \major \tonRVah \tonRVch
    \key d \major \tonRVbh 
  }
>> 
\markup { \fontsize #2 \bold "Ton VI" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn \key g \major \tempo "a" \tonRVIaf \tempo "c" \tonRVIcf \tempo "j" \tonRVIjf 
    \tempo "k" \tonRVIkf \tempo "l" \tonRVIlf \tempo "n" \tonRVInf \tempo "o" \tonRVIof
    \break\key f \major \tempo "b" \tonRVIbf\tempo "d" \tonRVIdf \tempo "f" \tonRVIff 
    \tempo "g" \tonRVIgf \tempo "h" \tonRVIhf \tempo "i" \tonRVIif \tempo "p" \tonRVIpf
    \break\key ees \major \tempo "e" \tonRVIef \tempo "m" \tonRVImf \tempo "q" \tonRVIqf
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 	
    \cadenzaOn \key g \major \tonRVIah \tonRVIch \tonRVIjh \tonRVIkh
    \tonRVIlh \tonRVInh \tonRVIoh
    \key f \major \tonRVIbh  \tonRVIdh \tonRVIfh 
    \tonRVIgh \tonRVIhh \tonRVIih \tonRVIph
    \key ees \major \tonRVIeh \tonRVImh \tonRVIqh
  }
>> 
\markup { \fontsize #2 \bold "Ton VII" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn \key a \major \tempo "a" \tonRVIIaf \tempo "c" \tonRVIIcf 
    \break\key bes \major \tempo "b" \tonRVIIbf 
    \break\key g \major\tempo "d" \tonRVIIdf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 		
    \cadenzaOn \key a \major \tonRVIIah \tonRVIIch
    \key bes \major \tonRVIIbh 
    \key g \major\tonRVIIdh
  }
>> 
\markup { \fontsize #2 \bold "Ton VIII" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn \key bes \major \tempo "a" \tonRVIIIaf \tempo "c" \tonRVIIIcf 
    \tempo "d" \tonRVIIIdf
    \key c \major \tempo "b" \tonRVIIIbf 
    \key a \major \tempo "e" \tonRVIIIef
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 		
    \cadenzaOn \key bes \major \tonRVIIIah \tonRVIIIch \tonRVIIIdh
    \key c \major \tonRVIIIbh
    \key a \major \tonRVIIIeh
  }
>>
\markup { \fontsize #2 \bold "Ton C" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn \key c \major \tempo "a" \tonRCaf }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 		
    \cadenzaOn \key c \major \tonRCah }
>>

\markup { \fontsize #2 \bold "Ton X" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \cadenzaOn \key g \major \tempo "a" \tonRXaf 
    \key bes \major \tempo "b" \tonRXbf
  }
  \new Staff \with { \remove "Time_signature_engraver"} { 
    \clef bass 		
    \cadenzaOn \key g \major \tonRXah 
    \key bes \major \tonRXbh
  }
>>