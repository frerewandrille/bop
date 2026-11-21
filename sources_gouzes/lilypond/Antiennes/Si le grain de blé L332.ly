\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key b \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 66
          b4 d b a b2 fis fis4 a fis2 d\resp d e fis1\fermata\resp
          fis2 d b b1\fermata\bar"|"
          fis'2. a4 fis2.*2/3 \resp s4 a4 b2 b4 a b2 cis b1\fermata
          \bar"|."
        } \transpose a fis \tonIgf
        %\transpose e fis \tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          fis4 e fis g fis (e) d2 d4 e d2 d b b4 (cis) d1 d2 b b s1
          d2. e4 fis2. e4 fis2 fis4 g fis 2 e fis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Si le grain de blé tom -- bé en ter -- re ne meurt pas, il res -- te seul.
     Mais s’il meurt, il por -- te beau -- coup de fruit.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 cis d e d (cis) b2 b4 cis b2 b g g b1 b2 fis4 (g) fis2 b1
          d4 (cis) 
          \override BalloonText.annotation-balloon = ##f 
          <b \balloonText #'(1.5 . 2.5)\markup { "" } >
          (cis) d (e) 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1.5 . 2)\markup { "" } >
          (cis) d (cis) d e d (cis) b (cis) dis1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          b4 b b b b2 b4 (a) g fis g (a) b (a) \resp
          g (fis) e2 b1\fermata\resp b4 (cis) d (e) fis2 b,1\fermata
          b'4 (a) g (a) b (cis)\resp b (a) g (a) g cis b (a) g (a) b1\fermata
        }  \transpose a fis \tonIgh
        %\transpose e fis \tonIVch
      }
   >>
>>