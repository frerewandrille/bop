\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 60
         e4-> fis a-> b b2.\resp b4 cis-> d e2 d4-> cis b2\resp
         cis a4-> b d-> cis b2\resp b b4-> b a-> gis fis2\resp e gis4-> fis e2 e\fermata
         \bar"|."
       } \transpose a b \tonVIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 fis a e e2. e4 e fis gis2 fis4 e e2 e fis4 fis fis a e2 e e4 e cis 
         cis d2 cis4 (b) a cis b2 b
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Viens, Sei -- gneur Jé -- sus, nous vi -- si -- ter dans la paix,
     pour que, d’un cœur par -- fait, nous nous ré -- jou -- is -- sions en ta pré -- sen -- ce.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 fis a gis gis2. gis4 a a b2 b4 a gis2 a a4 a b fis gis2 gis gis4 gis a a a2 gis a4 a gis2 gis
        } \transpose a b \tonVIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> fis a-> e e2.\resp e4 a,-> fis' e2 b4-> b e2\resp
          a, d4-> cis b-> d e2\resp e2 e4-> e fis-> e d2\resp
          e4 (gis) fis-> d e2 e\fermata
        } 
      }
   >>
>>