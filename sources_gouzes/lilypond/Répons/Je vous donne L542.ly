\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c\major \time 2/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Dynamics 
   {
         c4 4 2 4 4 f f e d c2\bar"|"
         c\breve*1/8 c2\> a\! c\breve*1/8\> 2 2 d\!\pp
    }
   \new Staff = "femmes" \with {\remove Time_signature_engraver }
   <<
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très large, paisible" 2 = 44
         c4 4 2 4 4 f f e d c2\bar"|"
         c\breve*1/8 c2 a\fermata\resp c\breve*1/8 2 2 d\fermata
         \bar"|."
       } \tonXaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         a4 4 2 4 4 4 4 4 4 2 \breve*1/8 g2 fis g\breve*1/8 2 a a
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je vous donne un com -- man -- de -- ment nou -- veau_:
     "Aimez-vous les uns les" au -- tres, "comme je vous" ai ai -- més.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          f4 4 2 4 e d d c d f2 f\breve*1/8 e2 d e\breve*1/8 c2 e fis
        } \tonXah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 4 2 4 4 4 4 4 4 2 \breve*1/8 c2 d\resp 
          c\breve*1/8 e2 a d,\fermata
        } 
      }
   >>
>>