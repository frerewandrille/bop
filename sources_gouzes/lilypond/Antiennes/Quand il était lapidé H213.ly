\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         a2 a4 a c2 c4 c b2.\resp b4 g2 g4 g a2 a g g e\fermata\bar"|"
         e'-> d4-> a a-> a c2\fermata\resp
         a4 a c2\fermata a\fermata g\fermata a\fermata
         \bar"|."
       } \tonIVef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         a2 a4 a e2 e4 e e2. e4 e2 e4 e e2 e e e e
         e f4 f f f <e a>2 f4 e d2 d e e
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Quand il é -- tait la -- pi -- dé, É -- tien -- ne cri -- ait vers le Sei -- gneur_:
     "“Sei" -- gneur, en -- tre tes mains, je re -- mets mon es -- "prit !”"
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 a b2 b4 b cis2. cis!4 d2 d4 d cis!2 cis b b cis!
          cis! d4 d d d e2 c4 c a2 a b cis
        } \tonIVeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 a a2 a4 a g2.\resp g4 g2 g4 fis e2 e e e a\fermata
          a-> a4-> a a-> a a2\fermata\resp
          a4 g f2\fermata f\fermata e\fermata a,\fermata
        } 
      }
   >>
>>