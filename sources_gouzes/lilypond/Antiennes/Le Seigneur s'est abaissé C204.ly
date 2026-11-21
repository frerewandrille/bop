\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          g4-> g g g e e f2 a4-> a g g e e f2 e\fermata \breathe \allowBreak
          gis4-> gis e e a2 a4 a fis2 b4 b g2 (a) a1\fermata\bar "|."
        }\tonIIIdf
        %\tonIIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 d d d c c d2 c4 f d d c c d2 b
          e4 e b b c2 e4 e d2 dis4 fis e2 (fis!) fis1 
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Le Sei -- gneur s’est a -- bais -- sé sous la for -- me de l’es -- cla -- ve.
      Il nous fait as -- seoir près de lui dans la grloi -- re_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 2/2 \cadenzaOn
          b4 b b b c c a2 a4 c b b a a a2 gis
          b4 b gis! gis a2 c4 c a2 b4 b b2 (d) d1
        }\tonIIIdh
        %\tonIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4-> g g g a a d,2 f4-> f g g a a d,2 e\fermata \breathe
          e4-> e e e a,2 a4 c d2 b4 dis e2 (d) d1\fermata
        }
      }
   >>
>>