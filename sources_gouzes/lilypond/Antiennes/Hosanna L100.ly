\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key cis \minor \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }

%\transpose b a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  \markup {\dynamic { ff }{ } vif, marqué }
          \partial4 e4 e2 (b'4) b2.\resp \silN b4 a gis2. a4-> b cis b2.\bar"|"
          \silN gis4 ais b2-> b4 cis2 cis4 b2 \allowBreak b4 gis-> a gis e2.\fermata\bar"|"
          \silB a4 a2 \resp fis4 a-> b a a2. (gis) \bar"|"
           e4 e2-> (b'4) b-> (cis a b2.)\resp \silN b4 fis fis2-> a4 b2.\fermata
          \bar "|."
        } \tonVIIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 e4 e2 (gis4) gis2. s4 e fis eis2. fis4 4 a fis2.
          s4 e fis4 2 4 a2 4 fis2 4 e e e e2. s2 e4 e2 dis4 e dis e e2.~ e
          e4 e2. e2 (fis1) s4 fis e fis2 e4 fis2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Ho -- san -- na_! Ô Jé -- sus, fils de Da -- vid.
     Bé -- ni soit ce -- lui qui vient au nom du Sei -- gneur_!
     Le Christ, le Roi d’Is -- ra -- ël_!
     Ho -- san -- na au plus haut des cieux_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure\cadenzaOn
          \partial4 e4 e2 (b'4) b2. \silN b4 cis4 2. 4 dis e dis2.
          \silN cis4 4 dis2 4 e2 4 dis2 4 b cis b b2.
          \silB cis4 2 b4 cis b cis cis2. (b)
          e,4 e2 (b'4) b (a cis dis2.) \silN dis4 cis dis2 cis4 dis2.
        } \tonVIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 e4 e2. e\fermata\resp s4 gis fis cis2. fis4-> b a b2.
          s4 cis fis, b2-> 4 a2 4 b2 4 e,-> a e e2.\fermata
          s2 a4 a2\resp b4 a-> fis a a2. (e)
          e4 e2-> (gis4) gis-> (a fis b2.)\resp s4 b a b2-> fis4 <b, b'>2.\fermata
        }
      }
   >>
>>