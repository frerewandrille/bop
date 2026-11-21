\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 56
          e2^\< e e4 e a2 a4 a a2. a4 gis2\fermata\resp 
          b4 b e2^\f^\> (d4 c) d2 c b1\fermata\!
          \bar"|."
        } \tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e e4 e c2 c4 d e2. e4 e2 e4 e f2 (a) f e e1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Je suis a -- vec toi pour te dé -- li -- vrer de la main des pé -- cheurs.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 b b4 b a2 a4 a b2. b4 b2 gis4 gis a1 a2 a gis!1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 g g4 g f2 f4 f e2. e4 e2\fermata\resp 
          e4 e d2 (f4 e) d2 e e1\fermata
        } \tonIIIah
      }
   >>
>>