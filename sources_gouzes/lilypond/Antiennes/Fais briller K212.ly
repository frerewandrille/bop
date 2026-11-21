\version "2.24.0"
%\include "TonsDef.ly"

\transpose a g
\new ChoirStaff
<< \new Dynamics 
   {
     a2 a4 d2 d4 c2 b4^\< a2. a \breathe \allowBreak c b2 c4 a2.\f \bar "|"
     a4^\ff^\< a a e'2. e4 e e d2^\> (c8 [b]) a2 \allowBreak a4 c2. b2 (c4) a2.\p \bar "|."
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn \tempo "Mystérieux, large" 2. = 60
          a2 a4 d2 d4 c2 b4 a2. a \breathe \allowBreak c b2 c4 a2.\fermata \bar "|"
          a4 a a e'2. e4 e e d2 (c8 [b]) a2 \allowBreak a4 c2. b2 (c4) a2. \bar "|."
        }\tonIIIdf
        %\tonIIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          fis2 fis4 e2 e4 fis2 fis4 e2. fis e fis2 e4 fis2.
          fis4 fis fis g2. g4 g g fis2 (e4) fis2 fis4 e2. e fis
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
     Fais2 bril4 -- ler2 sur4 nous2 ta4 fa2. -- ce, Sei -- gneur2 Jé4 -- sus_!2.
     Et4 tous les peu2. -- ples4 de la ter 2. -- re2 se4 -- ront2. sau -- vés_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
          d2 d4 c2 c4 d2 d4 c2. d c d2 c4 d2. \oneVoice
          d4 d d c2. c4 c c a2 (c4) d2 d4 a2. c d
        }\tonIIIdh
        %\tonIIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d2 d4 a'2 a4 d,2 d4 a'2. d, \breathe a' d,2 a'4 d2.\fermata
        }
      }
   >>
>>