\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         \partial8 f8 g a\breve*1/8 g8 bes2 a\resp
         f8 g a\breve*1/8 a4 g8 f g4 f\resp
         f8 f g4 g8 f a2
         \bar"|."
       } \tonVIjf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f8 f f\breve*1/8 f8 f2 f f8 f 
         f\breve*1/8 f4 f8 f c4 c c8 c f4 e8 c f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que le "Seigneur nous bénisse et" nous gar -- de.
     Que le "Seigneur nous dé" -- cou -- vre sa fa -- ce
     et nous don -- ne sa paix_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 bes c\breve*1/8 bes8 d2 c
          a8 bes c\breve*1/8 c4 bes8 a bes4 a
          a8 a bes4 bes8 a c2
        } \tonVIjh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/8 s f8 f2 f \resp
          f\breve*1/8 s f4 f8 f c4 f\resp
          f8 f c4 c8 f f2
        } 
      }
   >>
>>