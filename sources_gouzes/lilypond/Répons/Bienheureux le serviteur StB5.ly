\version "2.24.0"
%\include "TonsDef.ly"
%\include "TonsRDef.ly"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a\major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }


\transpose cis b,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme et reccueilli" 2 = 72
         cis2 b4 (cis) a2. b4 cis2 d cis1\resp
         cis2 b4 (cis) a2. b4 cis2 d b1\resp
         b2 cis2 1 a2 b2 1\fermata
         \bar"|."
       } \tonVIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         a2 gis fis2. 4 gis2 fis4 (gis) a1 2 gis fis2. 4 gis2 fis gis1 2 2 1 fis2 gis2 1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Bien -- heu -- reux le ser -- vi -- teur 
     que le maître à son re -- tour trou -- ve -- ra vi -- gi -- lant.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e2 e cis2. d4 e2 d e1 2 2 cis2. d4 e2 d e1 e2 eis2 eis!1 cis2 e2 1
        } \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 e fis (e4) d cis2 b a1\resp
          a'2 e fis (e4) d cis2 b e1\resp
          e2 cis2 1 fis2 e2 1\fermata
        }
      }
   >>
>>