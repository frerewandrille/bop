\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes\major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Large et grave" 4 = 72
         fis4 g g8 [g] g4. g8 ees4 f g2\resp
         a4 a8 [a] g2 fis4 g2\fermata
         \bar"|."
       } \tonIIff % Original à quatre-cinq stiques
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d4 c c8 [c] b4. 8 c4 c d2 f!4 8 [f] d2 4 2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je suis comme un hom -- me sans se -- cours, li -- bre par -- mi les morts_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 g4 8 [g] 4. 8 4 a b2 c4 8 [c] bes4 
          <a \balloonText #'(2 . 3)\markup { "" } >2 bes
        } \tonIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 ees4 8 [8] d4. 8 c4 c <g g'>2 \resp
          f'!4 8 [f] g4 d2 g\fermata
        } 
      }
   >>
>>