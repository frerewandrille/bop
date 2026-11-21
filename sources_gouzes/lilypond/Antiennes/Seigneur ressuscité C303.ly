\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "Léger" 2. = 63
          b4->^\f g c b a2-> b2. g2^\p g4 fis2 g4 g2 fis4 g2. 
          g2^\< g4 g^\> fis g fis2\fermata\!\resp
          fis4^\< g fis g a\! a b g2.^\markup\italic"rall." 
          g2^\markup\italic"large" a4 \noBreak a2.\fermata
          \bar "|."
        }\cadenzaOn \tonVIbf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c''
        {
          g4 d g g2 
          \override BalloonText.annotation-balloon = ##f 
          <fis \balloonText #'(-1 . -2)\markup { "" } >4
          g2. d2 d4 d2 d4 e (d) d d2.
          d2 d4 e d d d2 dis4 e dis e fis fis fis e2. e2 e4 fis2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Sei -- gneur res -- sus -- ci -- té, 
      prê -- tre pour l’é -- ter -- ni -- té,
      in -- ter -- cè -- de pour nous,
      que tu as sau -- vés sur l’au -- tel de la croix_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \armure
          d4 c e d2 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(-1 . 2)\markup { "" } >4
          d2. b2 b4 a2 b4 c (b) a b2.
          b2 b4 c a b a2 b4 b b b d d dis b2. c2 cis4 <a d>2.
        }\cadenzaOn \tonVIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g4-> g c, g' d2-> g2. g2 g4 d2 g4 c, (d) d g2.
          g2 g4 c, d g d2\fermata\resp
          b4 e b e d d b e2. c2 a4 d2.\fermata
        }
      }
   >>
>>