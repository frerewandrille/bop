\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          g2 g g4 g bes1 c2 c d1\fermata\resp 
          d2 d d4 c c (bes) bes2 \allowBreak a a g1\fermata
          \bar"|."
        } \transpose a d' \tonIef 
        %\transpose a g \tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d d4 d ees2. (f4) g (f) ees (g) fis1 
          fis!2 a a4 a a (g) g2 g fis! d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ve -- nez, a -- do -- rons le Sei -- gneur, 
     qui sau -- ve le mon -- de par sa croix_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 bes bes4 bes g1 g2 g a1 a2 d d4 d d2 d ees d4 (c) bes1
        } \transpose a d' \tonIeh 
        %\transpose a g \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 f f4 f ees2. (d4) ees (d) c (ees) d1\fermata\resp 
          d2 fis fis4 fis g2 g c, d g1\fermata
        } 
      }
   >>
>>