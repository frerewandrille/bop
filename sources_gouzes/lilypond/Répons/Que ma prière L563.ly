\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 2/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< 
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo \markup{\dynamic ppp", très lent"} 2 = 54
         a2 4 4 2 (g) f\fermata\resp 
         f\breve*1/8 f4 2\fermata g\fermata a1\fermata
         \bar"|."
       } \transpose b a \tonVIif %pas de ton dans l'orig.
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2 4 4 e1 d2 \breve*1/8 4 2 2 f1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que ma pri -- è -- re "vienne jus" -- qu’à toi, Sei -- gneur_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 4 4 1 a2 \breve*1/8 4 bes2 2 c1
        } \transpose b a \tonVIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 4 4 c1 d2\fermata \resp 
          \breve*1/8 c4 bes2\fermata 2\fermata <f f'>1\fermata
        } 
      }
   >>
>>