\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose gis e
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2. = 60
         gis4 b2 4 a-> (b) a gis2. \allowBreak b2 cis4 d-> (cis) d b2.\resp
         2 4 a-> b a gis2. \allowBreak 2^\markup\italic"élargir, piano" a4 b2 4 a2 b4 gis2\fermata
         \bar"|."
       } \transpose a b \tonVIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 gis2 4 fis (gis) fis e2. gis2 a4 b (a) b gis2.
         2 4 fis-> gis fis e2. 2 4 2 4 2 dis4 e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La gloi -- re du Sei -- gneur va se ré -- vé -- ler, 
     et tout hom -- me ver -- ra le sa -- lut de no -- tre Dieu_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 e2 4 2 4 b2. e2 4 2 4 2. 2 4 4 4 4 b2. 2 4 2 4 2 4 2
        } \transpose a b \tonVIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e\breve*7/8 e2. 2 4 2 4 2. \resp 2 4 4-> 4 4 2. 2 fis4 gis2 4 fis2 4 e2\fermata
        } 
      }
   >>
>>