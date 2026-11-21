\version "2.24.0"
%\include "TonsDef.ly"
%\include "TonsRDef.ly"
\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "" 4 = 80
         f4 4 4 g2 f4 2.\resp f4 ees f g2 f4 2 4\resp
         bes\breve bes4 4 4 a2. a\resp a4 g a bes2 4 2.
         \bar"|."
       } \tonVIIIif
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d d ees2 c4 d2. 4 c d ees2 c4 d2 4
         f\breve f4 ees f f2. f f4 f f f2 4 2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Bé -- ni sois_- tu ô Christ qui viens sau -- ver ton Peu -- ple_!
     "Tes disciples marchent" de -- vant ta Fa -- ce
     pour pré -- pa -- rer tes voies.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 4 4 2 a4 bes2. 4 4 4 2 a4 bes2 4
          d\breve d4 c d ees2. 2. 4 4 4 d2 4 2.
        } \tonVIIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes4 4 4 ees2 f4 bes,2.\resp 4 4 4 ees2 f4 bes,2 4 \resp
          bes'\breve 4 4 4 f2. f\resp 4 4 4 <bes, bes'>2 <bes bes'>4 2.
        } 
      }
   >>
>>