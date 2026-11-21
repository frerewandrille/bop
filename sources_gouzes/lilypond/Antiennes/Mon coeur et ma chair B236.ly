\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time 4/4 \omit Score.BarLine \tempo 4 = 80
          d8 [e] g a a2 g8 a c (b16 c d8) a a4. \breathe
          a8 a [b] g4 (a8 b c a) a2\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \transpose a g \tonVIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d8 [e] g a fis2 e8 fis a4 (fis8) g fis4. 
          fis8 fis [e] d4 (e8 fis g4) fis2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Mon cœur et ma chair ont cri -- é de joie
      de -- vant ta fa -- ce_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \key g \major
          d8 [e] g a d2 d8 d e (d16 e d8) e d4. 
          d8 d [c] b4 (c8 d e4) d2
        }\cadenzaOn \transpose e d \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          d8 [e] g a d,2 d8 d a'4. a8 d,4. \breathe 
          d8 d [d] g2. d2\fermata
        }
      }
   >>
>>