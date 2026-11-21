\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
           a4 bes c\breve*1/8  bes4 c d2 c4 bes c2 a\fermata\resp
           f4 g a\breve*1/8 g4 a bes2 a4 g a2 a\fermata
          \bar"|."
        } \tonVIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 g a\breve*1/8 g4 a bes2 a4 g a2 f
          d4 e f\breve*1/8 e4 f g2 f4 e f2 f
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Leur pa -- "role a retenti jus" -- qu’aux loin -- tains de la ter -- re,
      et leur "message jus" -- qu’aux li -- mi -- tes du mon -- de.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c f\breve*1/8 f4 f f2 f4 f e2 d
          d4 d d\breve*1/8 d4 d d2 d4 d c2 c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f f\breve*1/8 d'4 c bes2 c4 d c (a) d,2\fermata\resp
          d4 d d\breve*1/8 bes'4 a g2 a4 bes f2 f\fermata
        } \tonVIhh
      }
   >>
>>