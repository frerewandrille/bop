\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
     e4\< e f f\> a a e2\! c'4\< c b b\> a a gis2\!\pp
     a4\ppp\< a a a a2.\> a4 a2 (gis!) a1\!     
   }
   \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 50
         e4 e f f a a e2\fermata\resp c'4 c b b a a gis2\fermata\resp
         a4 a a a a2. a4 a2 (gis!) a1\fermata
         \bar"|."
       } \tonIVef
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 e d d c d e2 e4 e e e c d e2 e4 e e e f!2. f4 e1 e
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Si tu dé -- chi -- rais les cieux_! Si tu des -- cen -- dais, Sei -- gneur_!
     Fais bril -- ler sur nous ta fa -- ce_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c a a a a gis2 a4 a g g a a b2 cis4 cis cis cis d2. d4 b1 cis!
        } \tonIVeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 a d, d f f e2\fermata\resp a,4 a e' e f f e2\fermata\resp
          a4 a a a d,2. d4 e1 a,\fermata
        } 
      }
   >>
>>