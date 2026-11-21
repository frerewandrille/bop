\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key cis \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose b a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo  2. = 50
          \partial4 e4 e2 (b'4) b2.\fermata\bar "|"
          \oneVoice r2 \voiceOne b4 b2-> b4 a-> gis a b2-> (cis4) b2.\bar "|"
          \oneVoice r4 \voiceOne gis ais b-> cis b gis-> a! gis e2.\fermata \bar "|"
          \oneVoice r2 \voiceOne a4 a2->\breathe fis4 a-> b a a2. (gis)\fermata \bar "|"
          e4 e2-> (b'4) b-> (cis a b2.) 
          \oneVoice r4 \voiceOne b fis fis2-> a4 b2.\fermata
          \bar "|."
        } \tonVIIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 e4 e2 (gis4) gis2. 
          s2 e4 e2 e4 fis eis fis fis2 (a4) fis2.
          s4 eis fis fis a! fis e! e e e2. s2 e4 e2 dis4 e dis e e1.
          e4 e2. e2 (fis1) s4 fis e fis2 e4 fis2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Ho -- san -- na_! Qu’il en -- tre, le Roi de gloi -- re, 
     le Sei -- gneur, le vail -- lant des com -- bats_: 
     Jé -- sus, le Roi d’Is -- ra -- ël_!
     Ho -- san -- na_! au plus haut des cieux_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure\cadenzaOn
          \partial4 e4 e2 (b'4) b2. s2 b4 b2 b4 cis cis cis dis2 (e4) dis2.
          s4 cis cis dis e dis b cis b b2. 
          s2 cis4 cis2 b4 cis b cis cis2. (b)
          e,4 e2 (b'4) b (a cis dis2.) s4 dis cis dis2 cis4 dis2.
        } \tonVIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 e4 e2. e\fermata 
          \oneVoice r2 \voiceTwo gis4 gis2-> gis4 fis-> cis fis b2-> (a4) b2.
          \oneVoice r4 \voiceTwo cis fis, b-> a b e,-> a e <e gis>2.\fermata
          \oneVoice r2 \voiceTwo a4 a2->\breathe b4 a-> fis a a2. (e)\fermata
          e4 e2-> (gis4) gis-> (a fis b2.) 
          \oneVoice r4 \voiceTwo b a b2-> fis4 <b, b'>2.\fermata
        }
      }
   >>
>>