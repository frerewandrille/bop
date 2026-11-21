\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key bes \major \time 2/4 \cadenzaOn \tempo 4 = 120
          d4 f8 [g] bes4. bes8 d ([bes] c) [d] c2 
          \breathe\allowBreak d8 [d] d [d] c4. \breathe\allowBreak 
          g8^\markup{\italic élargir} bes ([a]) g [f] g2\fermata
          \bar "|."
        }\cadenzaOn \tonIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d4 f8 [g] bes4. bes8 d ([bes] c) [g] a2 
          bes8 [bes] bes [bes] a4. d,8 ees4 d8 [d] d2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Ce jour est saint pour no -- tre Dieu_:
     La joie du Sei -- gneur est no -- tre rem -- part_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \key bes \major \time 2/4\cadenzaOn
          d4 f8 [g] bes4. bes8 d ([bes] c) [d] f2 
          f8 [f] f [f] f4. bes,8 c4 bes8 [a] bes2
        }\cadenzaOn \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          d4 f8 [g] bes4. bes8 d ([bes] c) [bes] f2 \breathe
          bes,8 [bes] bes [bes] f'4. \breathe g8 c,4 d8 [d] g2\fermata
        }
      }
   >>
>>