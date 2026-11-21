\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo \markup{ \dynamic ppp ", calme et lointain" } 2=66
         c2 c b b d d a a c1\fermata\resp
         2 2 a a b b g1 (a) b1.\fermata\bar"|"
         fis!2 2-> 2 a-> a fis!1 2 aes2 1.\fermata\resp
         aes!2 f1 2 2 aes!1 (f) f\fermata
         \bar"|."
       } \transpose a g \tonXaf %pas de ton dans l'orig.
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g2 g g g b b fis2 2 g1 2 2 fis!2 2 2 2 e1 (fis!) 1.
         dis2 2 2 e e d1 2 ees2 1. ees!2 d1 2 2 f1 (d) c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Cha -- que fois que nous man -- geons ce pain
     et bu -- vons à cet -- te cou -- pe,
     nous an -- non -- çons la mort du Sei -- gneur
     jus --\apostrophe qu'à ce qu'il vien -- ne_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e2 e e e fis fis d d e1 2 2 d d dis2 2 b1 (d) dis1.
          b2 b b c! c s1 b2 c c1. 2 s1 bes2 2 c1 (bes!) aes!
        } \transpose a g \tonXah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c2 c e e b b d d c1\fermata\resp
          2 2 d d b b e1 (d) b1.\fermata
          b'2 b-> b a-> a b1 2 aes aes1. \fermata\resp
          aes!2 bes1 2 2 f\breve 1\fermata
        } 
      }
   >>
>>