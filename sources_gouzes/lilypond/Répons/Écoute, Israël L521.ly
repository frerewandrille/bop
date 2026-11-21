\version "2.24.0"

\include "vowel-set.ly"
%\include "TonsDef.ly"

armure = { \key a\minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Dynamics 
   {
         a2\< e'1\> f2 e e\! a,\breve*1/8\< a2\! a\> b b cis\!\pp
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Lent" 2 = 48
         a2 e'1 f2 e e\fermata\resp a,\breve*1/8 a2-> a b b cis\fermata
         \bar"|."
       } \tonIIIgf %pas de ton dans l’orig.
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e2 e1 d2 e e e\breve*1/8 f2 f e e e
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     É -- coute, Is -- ra -- ël_! "Le Seigneur notre" Dieu est seul Sei -- gneur_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c?2 b1 b2 d c a\breve*1/8 a2 a a gis! a
        } \tonIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 gis1 gis2 gis a\fermata\resp c,\breve*1/8 d2-> d e e a,\fermata
        } 
      }
   >>
>>