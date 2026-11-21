\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key e \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2 = 66
          b2 b4 b g2 g c c b1\fermata\resp g2 g a1 g2 g fis1\fermata
          \bar"|."
        } \transpose a b \tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e4 e e2 e e4 (d) e (fis) g1 e2 e e1 e2 cis dis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      En -- tre tes mains, Sei -- gneur mon Dieu, 
      je re -- mets mon es -- prit.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g2 g4 g b2 b a4 (b) c2 d1 b2 b c1 b2 b b1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 e4 e e2 d c4 (b) a2 g1\fermata\resp e'2 d c1 e2 e b1\fermata
        } \transpose a b \tonIch
      }
   >>
>>