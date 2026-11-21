\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \relative c''
     { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
       r8 g8 a [b] g [b] a [g] d4.\resp g8 a ([b]) a ([g]) g2\fermata
       \bar"|."
     } \transpose a b \tonVIdf
   }
   \new Lyrics \lyricsto "soprano"
   {
     Christ est res -- sus -- ci -- té des morts, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "ténor"
   { \relative c''
     { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
       r2 r8 g8 fis [e] d [b] d [e] d\resp d e [e] d2\fermata
       \bar"|."
     } 
   }
   \new Lyrics \lyricsto "ténor"
   {
     Christ est res -- sus -- ci -- té des morts, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   { %\accidentalStyle neo-modern-voice
    \new Voice = "basses"
    \relative c'
     { \clef "bass" \armure \cadenzaOn
       r8 g8 fis [d] e [g] a [a] b4.\resp b8 c4 c b2\fermata
     } \transpose a b \tonVIdh
   }
   \new Lyrics \lyricsto "basses"
   {
     Christ est res -- sus -- ci -- té des morts, al -- lé -- lu -- ia_!
   }
>>