\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 56
          g4 ees'2 ees4 ees ees2 d4 c d2\fermata\resp 
          g,4 g a bes c2 bes a a1\fermata
          \bar"|."
        } \transpose e g \tonIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g2 g4 g g2 g4 g g2 d4 d d d g2 g g fis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Je vais te con -- duire au dé -- sert, et je par -- le -- rai à ton cœur.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 c2 c4 c c2 bes4 a bes2 bes4 bes c d ees2 d c d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 c,2 c4 c c2 d4 d <g, g'>2\fermata\resp 
          g'4 g g g c,2 d ees d1\fermata
        } \transpose e g \tonIIch
      }
   >>
>>