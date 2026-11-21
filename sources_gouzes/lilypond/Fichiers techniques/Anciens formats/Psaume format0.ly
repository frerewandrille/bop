\paper {line-width = #(+ line-width (* mm 4)) }
#(set-global-staff-size 11)
\layout { ragged-last = ##t 
          \context { \Staff  %\override StaffSymbol.thickness = #0.5 
                     \override Script.font-size = #-1
          }
          \context { \Lyrics 	
                     \override LyricText.font-size = #4 	
                     \override LyricText.font-name = #"TeX Gyre Pagella" 
                     \override LyricSpace.minimum-distance = #1
          } 
          \context { \Score \remove "Bar_number_engraver" }
}	
\include "TonsDef0.ly"
%\include "TonsRDef.ly"
\include "vowel-set.ly"