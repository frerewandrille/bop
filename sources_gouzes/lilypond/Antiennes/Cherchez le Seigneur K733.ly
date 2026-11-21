\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e b,
\new ChoirStaff
<< \new Dynamics 
   {
     e2^\< e4 e2^\> e4 b2.\!\resp 
     a2^\< a4 c^\> b a a2.\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 48
          e2 e4 e2 e4 b2.\fermata\resp 
          a2 a4 c b a a2.\fermata
          \bar"|."
        } \tonIIIhf%\transpose d e \tonIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          a2 a4 c (b) a b2. e,2 e4 fis fis fis e2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Cher -- chez le Sei -- gneur, et votre â -- me vi -- vra_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e2 e4 fis2 fis4 g2. e2 e4 d d d e2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 c4 c2 c4 <e, e'>2.\fermata\resp a2 a4 a a a a2.\fermata
        } \tonIIIhh%\transpose d e \tonIfh
      }
   >>
>>