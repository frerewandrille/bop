\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose c bes, {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \armure \cadenzaOn \tempo  2 = 50
            c4 c^> c c^> c e2 e4^> d d2\fermata\resp 
            d4^> d d^> d c^> (b) a2 b1\fermata
            \bar"|."
          } \tonIIIhf
        }
        \new Voice = "alto" \with { \consists "Balloon_engraver" }
        { \voiceTwo \relative c'
          { 
            e4 e e e e fis2 fis4 fis g2 g4 g g g e2. 
            \override BalloonText.annotation-balloon = ##f 
            <fis! \balloonText #'(-2 . -2)\markup { "" } >4
            gis1
          }    
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       Le Jus -- te qui é -- tait sans pé -- ché, 
       Dieu l’a fait pé -- ché pour nous.
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            a4 a a a a a2 a4 a b2 b4 b b b c (d) e2 e1
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c'
          { 
            a4 a_> a a_> a d,2 d4_> d g2\fermata\resp 
            g4_> g g_> g a2 a e1\fermata
          } \tonIIIhh
        }
     >>
  >>
}