\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn %\tempo "" 2 = 52
          bes\breve*1/8 bes2 \breathe\allowBreak bes4 a bes c c2\breathe\allowBreak 
          c\breve*1/8  d2 \allowBreak bes a a1\fermata\bar"|"
          d\breve*1/8  ees4 ees d2 c bes\fermata\breathe\allowBreak
          bes\breve*1/8^\markup{\italic rall.} a2 a a g1\fermata\bar"|."
        }\tonIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 g2 g4 g g g g2 g\breve*1/8 a2 g g fis1
          g\breve*1/8 fis!4 fis g2 a g g\breve*1/8 g2 g fis! d1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      "Aux jours de sa" chair, le Fils a cri -- é 
      "vers celui qui pouvait le sau" -- ver de la mort_!
      "Il est devenu" sour -- ce de sa -- lut 
      "pour tous ceux qui" sont é -- prou -- vés.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          d\breve*1/8 d2 d4 c d ees ees2 ees\breve*1/8 d2 d ees s1
          d\breve*1/8 c4 c bes (c) d2 d d\breve*1/8 ees2 d d4 (c) bes1
        }\tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 g2\breathe g4 g g g g2\breathe 
          g\breve*1/8 fis2 g c d1\fermata
          bes\breve*1/8 a4 a g2 fis! g\fermata\breathe 
          g\breve*1/8 c,2 d d g1
        }
      }
   >>
>>