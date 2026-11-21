\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key f \major \cadenzaOn \tempo "Lent, bien scandé" 2. = 44
          d2. d4 e d c2. f,2 g4 a2. \breathe\allowBreak
          d2. d4 (e) d c2 c4 f,2 g4 a2. \breathe\allowBreak
          g2 (a8) [g] f2 f4 e2 e4 d2. \breathe\allowBreak d c d\fermata \bar "|."
        } \tonIbf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { \cadenzaOn
          f2. f4 g f e2. d2 d4 f2.
          f2. f4 (g) f e2 e4 d2 d4 f2.
          e2 (f8) [e] d2 d4 c2 c4 bes2 (g4) a2. a a
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      Christ2. ma4 -- ni -- fes -- té2. dans2 la4 chair,2.
      Christ2. pro2 -- cla4 -- mé2 chez4 les2 pa4 -- ïens,2.
      Gloire2 \skip8 à8 toi,2 Sei4 -- gneur2 Jé4 -- sus,2. gloire à toi.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key f \major \cadenzaOn
          a2. a4 a a a2. d2 d4 c2.
          a2. a2 a4 a2 a4 d2 d4 c2.
          c2 (c8) [c] a2 a4 a2 a4 f2. f e2 (g4) f2.
        }\tonIbh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          d2. d4 d d a'2. bes2 bes4 f2. \breathe
          d2. d2 d4 a'2 a4 bes2 bes4 f2. \breathe
          c2 (c8) [c] d2 d4 a2 a4 bes2. \breathe
          f2 (g4) a2. d\fermata
        }
      }
   >>
>>