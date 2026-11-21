\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

resp = { \breathe\allowBreak }

\transpose a e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 3/4 \cadenzaOn\tempo 2. = 44
          a2 a4 b2. e4^> e d c2. b2 a4 gis!2.\fermata\resp
          a2^\markup{\dynamic pp\italic"détaché"} a4 b^> b b c2 c4 b2 b4 a2.\fermata
           \bar "|."
        } \tonIIIaf
        %\tonIIIif
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          e2 e4 e2. gis4 gis gis a2 (e4) e2 e4 e2. e2 e4 g! g g g2 g4 g2 g4 e2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Qui me suit ne mar -- che pas dans la nuit_: 
     Il au -- ra la lu -- miè -- re de la vie_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4\cadenzaOn
          c2 c4 b2. b4 b b a2 (c4) d2 c4 b2. cis2 cis4 d d d e2 e4 d2 d4 cis2.
        } \tonIIIah
        %\tonIIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          a2 a4 gis2. e4_> e e a2. gis2 a4 e2.\fermata\breathe
          a2 a4 g!_> g g <c,! c'!>2 <c c'>4 g'2 g4 a2.\fermata
        }
      }
   >>
>>