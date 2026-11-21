\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 44
          a2. (b) cis1.\fermata 
          cis4 cis b a2 a4 gis2. gis4 gis gis a2 (b4) b1\fermata\bar "|"
          b4 b b cis2 cis4 a2. b2 a4 gis1.\fermata
          \bar"|."
        } \transpose c a, \tonIIIaf %\tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2. (gis) gis1. gis4 gis gis fis2 fis4 eis2.
          eis4 eis eis fis2 (gis4) gis1
          gis4 gis gis gis2 gis4 fis2. gis2 fis4 eis!1.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Pè -- re, je viens en ta mai -- son pour l’ho -- lo -- caus -- te.
      N’é -- loi -- gne pas de moi ton a -- mour_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          cis2. (e) eis1. eis!4 eis eis cis2 cis4 cis2.
          cis4 cis cis cis2 (e4) e1 e4 e e eis2 eis4 cis2. e2 cis4 cis1.
        } \transpose c a, \tonIIIah %\tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2. (e) cis1.\fermata cis4 cis cis fis2 fis4 cis2.
          cis4 cis cis fis2 (e4) e1\fermata
          e4 e e cis2 cis4 fis2. e2 fis4 cis1.\fermata
        } 
      }
   >>
>>