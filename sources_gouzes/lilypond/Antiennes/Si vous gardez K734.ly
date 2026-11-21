\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes g {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \armure \cadenzaOn \tempo 2 = 52
            bes\breve*1/16 bes2 bes4 a g2 g4\resp 
            d'\breve*1/16 ees2. ees4 ees ees d2\resp
            g,4 g g a bes2. bes4 a2 a g\fermata g\fermata
            \bar"|."
          } \transpose g bes \tonIIcf
        }
        \new Voice = "alto"
        { \voiceTwo \relative c''
          { 
            g\breve*1/16 g2 f4 f d2 d4 
            g\breve*1/16 g2. g4 g a bes2
            d,4 d d d g2. g4 g2 f4 (ees) d2 d
          }    
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       "Si vous gar" -- dez ma Pa -- ro -- le, "vous connaî" -- trez la vé -- ri -- té, 
       et la vé -- ri -- té vous ren -- dra li -- bres_!
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            d\breve*1/16 d2 d4 c bes2 bes4 
            bes\breve*1/16 c2. c4 c c g2
            bes4 bes bes c d2. d4 ees2 d4 (c) bes2 bes
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c'
          { 
            g\breve*1/16 g2 d4 f g2 g4\resp 
            g\breve*1/16 c,2. c4 c c g'2\resp 
            g4 g g g g2. g4 c,2 d g\fermata g\fermata
          } \transpose g bes \tonIIch
        }
     >>
  >>
}