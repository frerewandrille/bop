\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 60
         e4 fis2-> a4-> b b2.\resp b4 b2 b4-> b cis-> d e2 (d4 cis) b->\resp
         cis a-> b d-> (cis) b2.\resp b4 b-> b a-> gis fis2\resp
         fis4-> fis e2 gis4 -> fis e2\fermata
         \bar"|."
       } \transpose a b \tonVIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 fis2 a4 e e2. e4 e2 e4 e e fis gis2 (fis4 e) e e fis fis fis (a) e2.
         e4 e e cis cis d2 d4 d cis (b) a cis b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci qu’en ce jour, nos pè -- res se ré -- jou -- is -- sent de la Pro -- mes -- se_:
     de l’ar -- bre de Jes -- sé un ra -- meau a fleu -- ri_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
     e4 fis2 a4 gis gis2. 4 2 4 4 a a b2. (a4) gis4 a a a b (fis) gis2. 4 4 4 a a a2 
     a4 a gis2 a4 a gis2          
        } \transpose a b \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 fis2-> a4-> e4 e2.\resp 4 2 e4-> 4 a,-> fis' e2 (b) e4->\resp
          a, d-> cis b-> (d) e2.\resp 4 e-> e fis-> e d2\resp
          d4-> 4 e (gis) fis-> d e2\fermata
        } 
      }
   >>
>>