\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
barre = { \undo \omit Score.BarLine }
barress = { \omit Score.BarLine }

\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
     
   }
   \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "" 2. = 50
          \revert Staff.TimeSignature.style
          \barress
         
          \barre
          \bar "|."
        }\cadenzaOn \ton
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        {
         
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto soprano 
   { 
     
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          
        }\cadenzaOn \ton
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          
        }
      }
   >>
>>