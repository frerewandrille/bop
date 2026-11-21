\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\transpose b a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo "Lent" 4 = 72
          b2 b4 b b2. \breathe\allowBreak b4 c b a2. a4 fis2 a g (fis) e2.\fermata\bar "|"
          e4 e e e2.\fermata\breathe\allowBreak e4 dis!2. dis4 e2\fermata\bar "|."
        }\transpose a b \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 fis4 fis g2. g4 a e e2. dis4 dis2 e e2. (dis!4) b2.
          b4 b b c2. b4 b2. b4 b2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu n’as vou -- lu ni ho -- lo -- caus -- te, ni vic -- ti -- me, 
     a -- lors j’ai dit_: "“Voi" -- ci, je "viens !”"
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          e2 dis4 dis e2. e4 e b c2 (b4) a b2 a b1 g2. g4 g g a2. g4 fis2. fis4 gis2
        }\transpose a b \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 b'4 b e,2. \breathe e4 a gis a2 (g4) fis b,2 c b1 e2.\fermata
          e4 e e a,2. \fermata\breathe b4 b2. b4 e2\fermata
        }
      }
   >>
>>