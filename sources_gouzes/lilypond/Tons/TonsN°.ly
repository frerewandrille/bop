\version "2.24.0"

\header { title = "Tons de psalmodie" composer = " " tagline = "" }
\layout { indent = 0\mm		
          ragged-right = ##t }
#(set-global-staff-size 16)

\include "TonsDef.ly"

\markup { \fontsize #2 \bold "Ton I" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key d \minor 
    \tempo "a" \tonIaf \tempo "b" \tonIbf %\break 
    \tempo "c" \tonIcf \tempo "d" \tonIdf \tempo "e" \tonIef
    \tempo "h" \tonIhf \tempo "g" \tonIgf 
    \tempo "f"  \key g \minor \tonIff
    \key d \minor \tempo "m" \tonImf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key d \minor 
    \tonIah \tonIbh \tonIch \tonIdh \tonIeh \tonIhh \tonIgh
    \key g \minor \tonIfh 
    \key d \minor \tonImh 
  }
>> 

\markup { \fontsize #2 \bold "Ton II" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn 
    \key d \minor \tempo "a" \tonIIaf \tempo "b" \tonIIbf \tempo "h" \tonIIhf 
    \tempo "e" \tonIIef \tempo "j" \tonIIjf \tempo "k" \tonIIkf  
    \break\key a \minor \tempo "IIIa" \tonIIIaf  
    \tempo "IIIh" \tonIIIhf  \tempo "IIIf" \tonIIIff \tempo "IIIi" \tonIIIif 
    \tempo "IIIg" \tonIIIgf
    \break\key e \minor \tempo "c" \tonIIcf \tempo "d" \tonIIdf 
    \tempo "i" \tonIIif 
    \break\key g \minor \tempo "f" \tonIIff \tempo "g" \tonIIgf 
    \break\key fis\minor \tempo "IVi" \tonIVif
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn 
    \key d \minor 
    \tonIIah \tonIIbh \tonIIhh \tonIIeh  \tonIIjh\tonIIkh
    \key a \minor \tonIIIah \tonIIIhh \tonIIIfh \tonIIIih
    \tonIIIgh 
    \key e \minor \tonIIch \tonIIdh \tonIIih
    \key g \minor \tonIIfh \tonIIgh
    \break\key fis\minor \tonIVih
  }
>> 

\markup { \fontsize #2 \bold "Ton III" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key e \minor 
    \tempo "b" \tonIIIbf \tempo "c" \tonIIIcf %\break 
    \tempo "d" \tonIIIdf \tempo "e" \tonIIIef 
    \tempo "m" \tonIIImf }
  \new Staff \with { \remove "Time_signature_engraver"}
  { \clef bass \cadenzaOn \key e \minor 
    \tonIIIbh \tonIIIch \tonIIIdh \tonIIIeh \tonIIImh  
  }
>> 

\markup { \fontsize #2 \bold "Ton IV" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key a \minor 
    \tempo "a" \tonIVaf \tempo "b" \tonIVbf %\break 
    \tempo "c" \tonIVcf \tempo "e" \tonIVef \tempo "f" \tonIVff   
    \tempo "g" \tonIVgf \tempo "III f" \tonIIIff 
    \tempo "m" \tonIVmf %\break 
    \break\key d \minor \tempo "d" \tonIVdf \tempo "f" \tonIVhf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key a \minor 
    \tonIVah \tonIVbh \tonIVch \tonIVeh \tonIVfh \tonIVgh \tonIIIfh \tonIVmh 
    \key d \minor \tonIVdh \tonIVhh
  }
>> 

\markup { \fontsize #2 \bold "Ton V" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key bes \major 
    \tempo "a" \tonVaf \tempo "d" \tonVdf 
    \break\key c \major \tempo "b" \tonVbf \tempo "c"\tonVcf \tempo "f" \tonVff 
    \break\key d \major \tempo "e" \tonVef \tempo "g" \tonVgf
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key bes \major
    \tonVah \tonVdh 
    \key c \major \tonVbh \tonVch \tonVfh 
    \key d \major \tonVeh \tonVgh
  }
>> 

\markup { \fontsize #2 \bold "Ton VI" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key f \major 
    \tempo "a" \tonVIaf \tempo "c" \tonVIcf %\break 
    \tempo "d" \tonVIdf \tempo "g" \tonVIgf \tempo "h" \tonVIhf \tempo "j" \tonVIjf 
    \tempo "k" \tonVIkf \tempo "o" \tonVIof \tempo "m" \tonVImf \tempo "n" \tonVInf
    \break\key g \major \tempo "b" \tonVIbf \tempo "l" \tonVIlf %\break 
    \tempo "e" \tonVIef \tempo "f" \tonVIff  \tempo "i" \tonVIif  \tempo "p" \tonVIpf  
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key f \major 
    \tonVIah \tonVIch \tonVIdh \tonVIgh \tonVIhh \tonVIjh \tonVIkh \tonVIoh 
    \tonVImh \tonVInh
    \key g \major \tonVIbh \tonVIlh \tonVIeh \tonVIfh \tonVIih \tonVIph
  }
>> 

\markup { \fontsize #2 \bold "Ton VII" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key g \major
    \tempo "a" \tonVIIaf \tempo "b" \tonVIIbf \tempo "e" \tonVIIef 
    \tempo "f" \tonVIIff \tempo "h" \tonVIIhf 
    \break\key a \major \tempo "c" \tonVIIcf  \tempo "i" \tonVIIif
    \break\key e \major \tempo "g" \tonVIIgf
    \break\key d \major \tempo "j" \tonVIIjf
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key g \major
    \tonVIIah \tonVIIbh \tonVIIeh \tonVIIfh \tonVIIhh
    \key a \major \tonVIIch  \tonVIIih
    \key e \major \tonVIIgh
    \key d \major \tonVIIjh
  }
>> 

\pageBreak
\markup { \fontsize #2 \bold "Ton VIII" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key bes \major
    \tempo "a" \tonVIIIaf \tempo "b" \tonVIIIbf 
    \tempo "i" \tonVIIIif \tempo "c" \tonVIIIcf 
    \tempo "f" \tonVIIIff \tempo "g" \tonVIIIgf \tempo "h" \tonVIIIhf 
    \break\key c \major \tempo "d" \tonVIIIdf 
    \break\key a \major \tempo "e" \tonVIIIef \tempo "VIId" \tonVIIdf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key bes \major
    \tonVIIIah \tonVIIIbh \tonVIIIih \tonVIIIch  \tonVIIIfh \tonVIIIgh \tonVIIIhh 
    \key c \major \tonVIIIdh 
    \key a \major \tonVIIIeh \tonVIIdh
  }
>>

\markup { \fontsize #2 \bold "Ton X" }
\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key c \major
    \tempo "a" \tonXaf \tempo "c" \tonXcf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key c \major
    \tonXah\tonXch
  }
>>

\new StaffGroup <<
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \cadenzaOn \key d \major
    \tempo "b" \tonXbf 
  }
  \new Staff \with { \remove "Time_signature_engraver"} 
  { \clef bass \cadenzaOn \key d \major
    \tonXbh
  }
>>