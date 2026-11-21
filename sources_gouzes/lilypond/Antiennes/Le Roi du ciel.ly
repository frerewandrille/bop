\version "2.24.0"
%\include "TonsDef.ly"

global = { \key c \major \time 3/4 }

\transpose a g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn \tempo "Dansant et vif"% 2 = 52
          a2^\p a8 [e] a4-> a g a2-> c4 b2 (g4) e2\fermata \allowBreak \breathe
          c'4 b2 (a4) a2 (g4) a2.\fermata \allowBreak \breathe
          c4->^\f c b c2-> e4 d2 (b4) g2\fermata \allowBreak \breathe
          c4^\p b2 a4 a2 g4 a2\fermata \bar "|."
        } \transpose g a \tonIIaf %Pas de ton dans l’original
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { \cadenzaOn
          e2 e8 [e] e4 fis e e (fis!) g g (e b) c2 g'4 g2 (e4) fis! (e2) e2.
          g4 g g g2 g4 g2. g2 g4 g2 e4 fis! 
          \override BalloonText.annotation-balloon = ##f 
          <e \balloonText #'(2 . -2)\markup { "" } >2
          e
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le Roi du ciel nous in -- vite aux no -- ces, al -- le -- lu -- ia_! 
      Al -- lons à sa ren -- con -- tre, et chan -- tons son a -- mour_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \global \cadenzaOn
          c2 c8 [b] c4 d b c (d) e d (b g) g2 e'4 d2 (c4) d (b2) c2.
          e4 e d e2 c4 b2 (c4) d2 e4 d2 c4 d 
          \override BalloonText.annotation-balloon = ##f 
          <b \balloonText #'(2 . 2)\markup { "" } >2
          c
        } \transpose g a \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          a2 a8 [b] a4-> d, e a-> (d,) c g'2 (e4) c2 \fermata\breathe
          c4 g'2 (a4) d, (e2) a2.  \fermata\breathe
          c,4-> e g c2-> c4 g2 (a4) b2  \fermata\breathe
          c4 g2 a4 d, e2 a  \fermata
        }
      }
   >>
>>