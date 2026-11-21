\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << 
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure 
         \partial 4 e4 a2 b4 cis2 a4 d (e) cis cis2. b2 \resp
         b4 cis2 4 a2. \breathe e'2 d4 cis2 a4 b2 b4 cis2.\fermata
         \bar "|."
       }\cadenzaOn \transpose a cis' \tonVIaf %pas dans l’original
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       {
         e4 e (fis) e e2 fis4 4 (e) a fis2. gis2
         fis4 eis2 4 fis2. e2 b'4 a (e) fis4 2 e4 2.
       }          
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     La Croix du Christ est no -- tre gloi -- re.
     Sau -- vés par lui, nous vi -- vons res -- sus -- ci -- tés_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure
          e4 a,2 gis4 a2 e'4 d (b) e dis2. e2 
          b4 gis2 4 a2. cis2 d4 e (a,) a d (b) gis a2.
        }\cadenzaOn \transpose a cis' \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          e4 cis (d) e a,2 a'4 b (gis) a a2. e2\resp
          d4 cis2 4 fis2. \breathe 
          g!2 fis4 e (cis) d b8 (cis d4) e a,2.\fermata 
        }
      }
   >>
>>