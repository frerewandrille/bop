\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

global = {\key bes \major \time 3/4}
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn %\tempo "" 2 = 52
          g\breve*1/16 a4 a2\resp 
          bes4 bes a a g2 \bar "|"
          g4 g g g f2 f4\resp bes a (g) g fis g1\fermata \bar "|."
        } \transpose g bes \tonIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d\breve*1/16 f4 f2 f4 f f f d2 
          d4 d d e d2 d4 f ees (d) d d d1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      "Si vous avez part aux souffrances" du Christ, 
      ré -- jou -- is -- sez_- vous,
      car l’Es -- prit de gloi -- re re -- po -- se sur vous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \global \cadenzaOn
          bes\breve*1/16 c4 c2 d4 d c c bes2
          bes4 bes bes c a2 a4 d c (bes) a a bes1
        } \transpose g bes \tonIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g\breve*1/16 f4 f2 \breathe 
          bes,4 bes f' f g2 
          g4 g g c, d2 d4\breathe bes c (d) d d g1\fermata
        }
      }
   >>
>>