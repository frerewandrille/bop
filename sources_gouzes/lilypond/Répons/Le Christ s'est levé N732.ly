\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Andante"
         e4 a2 8 [a] fis2. a4 b b cis2. \resp
         4 4 4 e \allowBreak e e cis2. a2 b4 cis2.\bar"|"
         4 4 4 e e e cis2 (b4) cis2.\resp
         a4 a a cis4 4 4 a2\fermata (gis4\fermata) fis2.\fermata
         \bar"|."
       } \transpose c a, \tonIIIaf %orig. \tonVIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 cis (d) e8 [e] d4 (cis b) fis' d e e2. 
         4 4 a a a gis a (gis fis) 2 4 eis2.
         e4 e gis a a gis a (gis fis) eis2.
         cis4 e e d e fis fis (cis2) 2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Christ s’est le -- vé d’en -- tre les morts,
     lui qui pour nous fut clou -- é sur la croix,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 e2 a8 [a] 2. 4 4 gis a2. 
          4 4 e' cis4 4 4 2 (d4) d (cis) b gis2.
          a4 a e' cis4 4 4 a2 (b4) gis2.
          a4 a cis d a b cis2 (b4) a2.
        } \transpose c a, \tonIIIah %orig. \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 a, (b) cis8 [8] d4 (e fis) d fis e a,2.\resp
          4 a' gis fis fis e fis (e d) fis (e) d cis2.
          a4 cis e fis fis e fis (e d) cis2.\resp
          a4 cis e fis e d cis2.\fermata fis\fermata
        } 
      }
   >>
>>