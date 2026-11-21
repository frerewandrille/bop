\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }
psub = #(make-dynamic-script 
         (markup #:line 
           ( #:dynamic "pp" #:normal-text #:italic "sub." )))

\new ChoirStaff
<< \new Dynamics 
   {
     g2 g4 g c c a2. 
     \once \override DynamicText.X-offset = #0 
     a4\psub\> bes bes bes2
     bes4 bes g2\!^\ppp g
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 69
         g2 g4 g c c a2.\resp 
         a4 bes bes bes2
         bes4 bes g2 g\fermata
         \bar"|."
       } \transpose g bes \tonIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 d4 d g g f2. f4 g g g2 g4 g ees2 d
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tes mains m’ont fa -- çon -- né 
     pour mé -- di -- ter ta Pa -- ro -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 bes4 bes ees ees c2. c4 ees ees ees2 ees4 d c2 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 g c, c f2.\resp f4 ees ees ees2 ees4 g c,2 g'\fermata
        } \transpose g bes \tonIIdh
      }
   >>
>>