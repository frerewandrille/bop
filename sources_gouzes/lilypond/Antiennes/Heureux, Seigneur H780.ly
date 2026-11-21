\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn %\tempo 
          \partial 4 g4 g2 g4 a2 a4 bes2 g4 fis2 \allowBreak 
          a4 bes2 c4 bes2 (a4) bes2.\bar "|"  
          bes4-> bes bes a2 g4 g2 fis4 g2 \resp
          g4 fis2 g4 a2 \allowBreak a4 bes2 (a4) g2 (fis4) g2.\fermata
          \bar "|."
        } \tonIIaf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        {
          \partial 4 d4 d2 d4 f2 f4 f2 ees4 d2 fis4 g2 a4 f!2. d
          f4 f f f2 d4 ees 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(2 . -2)\markup { "" } >2
          d d4 d2 e4 f!2 f4 f2. d d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Heu -- reux, Sei -- gneur, les ha -- bi -- tants de ta de -- meu -- re, 
     eux qui sans fin te bé -- ni -- ront et chan -- te -- ront_: Al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \cadenzaOn
          \partial 4 bes4 bes2 bes4 c2 c4 d2 c4 a2 d4 d2 f4 d (c2) bes2. 
          d4 d d c2 b4 c 
          \override BalloonText.annotation-balloon = ##f 
          <a \balloonText #'(2 . 2.5)\markup { "" } >2
          bes!2 bes4 a2 c4 c2 d4 d2 (c4) bes (a2) b2.
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial 4 g4 g2 g4 f2 f4 bes,2 c4 d2 d4 g2 f4 bes (f2) bes,2.
          bes'4-> bes bes f2 g4 c, d2 <g, g'> \breathe 
          bes4 d2 c4 f2 d4 bes2 (f'4) g (d2) <g, g'>2.\fermata
        }
      }
   >>
>>