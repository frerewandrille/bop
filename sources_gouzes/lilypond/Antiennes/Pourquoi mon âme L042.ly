\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose c bes,
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Lent"% 2 = 52
          c2 c4 c b2 (a) gis\fermata\resp 
          gis4 gis a2 a4 b c2 c b2.\fermata\bar"|"
          b4 a2 a4 a a2 b4 gis! a2\fermata
          \bar"|."
        } \tonIIIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          a2 a4 a e2. (d4) e2 e4 e e2 e4 e e2 a gis!2. 
          gis!4 e2 e4 e f2 f4 e e2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pour -- quoi, mon â -- me, es_- tu tris -- te jus -- \apostrophe qu’à la mort_?
     Je vais vers l’au -- tel du Sei -- gneur_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e2 e4 e e (d c a) b2 b4 b c2 c4 d c (d) e2 e2. 
          e4 cis2 cis4 cis d2 d4 b cis!2
        } \tonIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 a gis2 (a4 f) e2\fermata\resp 
          e4 e a2 a4 gis! a2 a e2.\fermata e4 a2 a4 a d,2 d4 e a2\fermata
        } 
      }
   >>
>>