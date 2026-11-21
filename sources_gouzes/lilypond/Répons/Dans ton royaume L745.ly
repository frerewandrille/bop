\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key f\minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Très doux" 4 = 80
         f2 4 4 g2. (aes4) f1 \resp aes\breve*1/8 g4 f g2. 4 f1\fermata\bar"|"
         aes2 4 bes4 2 (aes4 g) f1\resp \breve*1/8 e!2. g4^\markup\italic"rall." (f2. e!4) f1\fermata
         \bar"|."
       } \transpose g aes \tonIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c2 4 4 1 1 f\breve*1/8 c4 4 2. 4 1 f2 4 4 g2 (f4 e) c1
         \breve*1/8 2. 4~ 1 1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dans ton roy -- au -- me, souviens_- toi de nous, Sei -- gneur_!
     Dans ton roy -- au -- me, "souviens-toi de" nous, Sei -- gneur_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          aes2 4 4 bes2. (c4) aes1 c\breve*1/8 bes4 aes bes2. 4 aes1
          c2 4 4 des2 (c4 bes) aes1 \breve*1/8 g2. bes4 (aes2. g4) aes1
        } \transpose g aes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 4 4 e1 f \resp \breve*1/8 4 4 e!2. 4 f1\fermata
          f2 4 4 e!2 (f4 c) f1\resp \breve*1/8 c2. 4~ 1 f\fermata
        } 
      }
   >>
>>