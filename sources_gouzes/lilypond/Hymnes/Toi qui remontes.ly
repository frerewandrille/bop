\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         bes4 g c bes2 g4 aes2 4 g2.\resp
         bes4 g aes bes2 4 aes2 g4 f2.\resp
         g2 f4 ees2. \allowBreak aes4-> 4 g f2 4 g2.\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 ees aes g2 ees4 2 d4 ees2. g4 ees4 4 2 4 d2 ees4 d2.
         ees2 d4 c2. f4 ees4 4 2 d4 ees2.
       }    
     }
   >>
   \new Lyrics \lyricsto "soprano"
   {
     Toi qui re -- mon -- tes des En -- fers ac -- com -- pa -- gné de tous les Saints,
     gloire à toi, Sei -- gneur res -- sus -- ci -- té_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          ees4 4 4 2 bes4 c2 bes4 2. ees4 bes c bes2 4 2 4 2.
          2 4 g2. c4 c c bes2 4 2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees4 4 aes ees2 4 aes,2 bes4 ees2.\resp
          4 4 aes g2 4 f2 ees4 bes2.\resp
          ees2 bes4 c2. f,4-> g aes bes2 4 ees2.\fermata
        } 
      }
   >>
>>