\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          d2 c4-> f g-> a a-> c a2\fermata\breathe\allowBreak
          d4-> d d-> d c c a a bes2 (a) a\fermata\bar "|."
        }\tonIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d2 c4 f g f f g fis2 f4 f g g a a f f g2 (e) fis
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Vous, les vi -- vants, bé -- nis -- sez Dieu,
      le Sei -- gneur du ciel et de la ter -- re_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
           d2 c4 f g c c c d2 d4 d d d e e f f d2 (cis) d
        }\tonIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d2 c4-> f g-> f f-> e d2\fermata\breathe
          bes'4-> bes bes-> bes a a d, d g2 (a) d,\fermata
        }
      }
   >>
>>