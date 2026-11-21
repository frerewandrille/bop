\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key bes \major \time 2/2 \cadenzaOn \tempo "Large et calme" 2 = 72
          f2 f g g4 bes bes2 a g1 \breathe \allowBreak
          f2 f4 f g2 bes bes (a) bes1\fermata\breathe \allowBreak
          bes2 bes c4 d d2 d c4 bes bes2 a bes1\fermata\bar "|."
        }\tonVIIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          c2 c4 (d) ees2 ees4 ees f2 f4 (ees) d1
          d2 d4 d d2 g f1 f
          f2 f g4 g g2 f ees4 ees f2 f f1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Dieu n’a pas en -- vo -- yé son Fils pour con -- da -- mner
      le mon -- de, mais pour que le mon -- de soit sau -- vé par lui.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 2/2 \cadenzaOn
          a2 a bes bes4 g bes2 c bes1 a2 a4 a bes2 c c1 d
          d2 d c4 c bes2 a bes4 bes c2 c d1
        }\tonVIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          f2 f ees ees4 ees d2 f g1 \breathe
          d2 d4 d g (f) ees2 f1 bes,\fermata\breathe
          bes4 (c) d2 ees4 ees ees2 f g4 g f2 f bes,1\fermata
        }
      }
   >>
>>