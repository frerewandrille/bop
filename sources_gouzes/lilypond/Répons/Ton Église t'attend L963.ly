\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c\minor \time 2/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Dynamics 
   {
     
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 50
         ees4 d c2 4 4 b2\resp c2 (d4) ees d2 (c4) b! c2\fermata
         \bar"|."
       } \transpose a g \tonIgf % pas de ton orig.
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 f ees2 4 4 d2 ees (f4) g f2 (ees4) d ees2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ton É -- gli -- se t’at -- tend_: Viens, Sei -- gneur Jé -- sus_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 4 g2 4 4 2 \resp 2 (bes4) 4 2 (g4) 4 2
        } \transpose a g \tonIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees4 bes c2 4 4 g2 c (bes4) ees bes2 (c4) g c2\fermata
        } 
      }
   >>
>>