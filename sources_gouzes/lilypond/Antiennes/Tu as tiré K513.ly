\version "2.24.0"

%\include "TonsDef.ly"
\include "TonsDef.ly"

\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn \tempo 2. = 66
          bes4-> bes bes a2 a4 bes2 bes4 bes2 c4 c2. \breathe \allowBreak
          d4-> d d c2 \allowBreak c4 bes2. \allowBreak c2 bes8 [c] d2 d4\fermata \bar "|."
        }\tonIIaf
        %\transpose a bes \tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          f4 f f fis2 fis4 g2 g4 g2 g4 a2.
          f4 f f fis2 fis4 g2. g2 g8 [g] a2 a4
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Tu as ti -- ré mon â -- me des en -- fers_!
      Tu as chan -- gé mon deuil en u -- ne dan -- se_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
          d4 d d d2 d4 d2 d4 e2 e4 f2. d4 d d d2 d4 d2. e2 d8 [e] fis2 fis4
        }\tonIIah
        %\transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          bes4-> bes bes d,2 d4 g2 g4 g2 g4 f2. \breathe
          bes4-> bes bes a2 a4 g2. g2 g8 [g] d2 d4\fermata
        }
      }
   >>
>>