\version "2.24.0"

\include "vowel-set.ly" \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     a\breve*1/16^\p^\< gis4^\> fis2\!
     gis4^\< a2 a\breve*1/16  b2^\> (a4) gis2\!\bar"|"
     cis8^\f ([d]) cis [b] a2 b cis
     a\breve*1/16 \hideNotes b\breve*1/16^\> \unHideNotes b2 (cis) a2\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
         a\breve*1/16 gis4 fis2\resp
         gis4 a2-> a\breve*1/16  b2-> (a4) gis2\bar"|"
         cis8 ([d]) cis [b] a2 b cis\fermata\resp
         a\breve*1/16
         \hideNotes b\breve*1/16 \unHideNotes b2 (cis) a2\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e\breve*1/16 d4 cis2 
         e4 e2 e\breve*1/16 e2. e2
         a4 a8 [e] e2 gis a a\breve*1/16 s e2 (gis) a
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "Au milieu de" la nuit, 
     un cri "s’est fait en" -- ten -- dre_:
     Voi -- ci l’É -- poux qui vient_!
     "Venez à sa" ren -- con -- tre_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          cis\breve*1/16 b4 a2 b4 cis2 cis\breve*1/16 d2 (cis4) b2
          e8 ([fis]) e [d] cis2 d e
          cis\breve*1/16 s d2 (e) cis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a\breve*1/16 e4 fis2\resp 
          e4 a2-> a\breve*1/16 gis2-> (a4) e2
          a4 a8 [a] a2 e a\fermata\resp
          a\breve*1/16 s gis2 (e) a\fermata
        } 
      }
   >>
>>