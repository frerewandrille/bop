\version "2.24.0"
%\include "TonsRDef.ly"
\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f\minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très lent" 2 = 60
         aes2 4 g f2. 4 g2. 4 f2\fermata\resp aes4 4 bes1 aes2 g aes1\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         ees2 4 4 c2. 4 2. 4 2 ees!4 4 1 2 2 1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     En -- tre tes mains, Sei -- gneur mon Dieu, je re -- mets mon Es -- prit.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 bes aes2. 4 bes2. 4 aes2 c4 c des1 c2 bes c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          aes2 4 ees f2. 4 e2. 4 f2\fermata\resp aes4 4 g1 aes2 ees <aes, aes'>1\fermata
        } 
      }
   >>
>>