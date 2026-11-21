\version "2.24.0"

\include "vowel-set.ly"

rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\transpose g f 
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn 
          \tempo \markup{ \concat {"Très léger, " " " \dynamic ppp", calme" } }
          b4 c^> b c d2. b s2 b4 b^> a b c^> b c d2. b \bar "|" 
          e4 e d c \agauche d2^\rall^\> c4 c b2\fermata\! \bar "|." 
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'' 
        {
          g4 a g a b2. g \oneVoice r2 \voiceTwo
          g4 g fis g a g a b2. g g4 g g g g2 g4 fis g2 
      } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { 
     Joy -- eu -- se lu -- miè. -- re_!
     Splen -- deur é -- ter -- nel -- le du Pè -- re_!
     Saint et bien -- heu -- reux, Jé -- sus Christ_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          d\breve*1/2 g2. d \oneVoice r2 \voiceOne
          d4 d\breve*3/4 g2. d
          g4 g g g g(d) e d d2 
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          g\breve*1/2 g2. g s2  g4 g\breve*3/4 g2. g
          c4 c b a b2 a4 a g2\fermata
      } }
   >>
>>