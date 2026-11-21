\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \minor \time 3/4 }

\transpose  g e {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
            bes\breve*1/16 bes4 a g2\breathe\allowBreak
            d'4 ees ees d2\breathe\allowBreak g,4 a bes2 bes4 a2 a2 g1\fermata
            \bar"|."
          }
        }
        \new Voice = "alto"
        { \voiceTwo \relative c''
          { 
            g\breve*1/16 f4 f d2 g4 g a bes2
            d,4 d g2 g4 g2 f4 (ees) d1
          }     \transpose g bes \tonIIcf     
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       "Celui qui perd sa vie à cau" -- se de moi la sau -- ve -- ra, 
       et sa chair re -- fleu -- ri -- ra_!
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            d\breve*1/16 d4 c bes2 bes4 c c g2 
            bes4 c d2 d4 ees2 d4 (c) bes1
          }
        }
        \new Voice = "basse"
        { \voiceTwo \relative c'
          { 
            g\breve*1/16 d4 f g2\breathe
            g4 c, c g'2\breathe
            g4 g g2 g4 c,2 d g1\fermata
          }\transpose g bes \tonIIch
        }
     >>
  >>
}