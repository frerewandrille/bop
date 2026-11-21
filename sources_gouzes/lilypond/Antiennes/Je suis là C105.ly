\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose g f
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2. = 44
         g2 g4 a2. e'4-> e e d2 (c4) b2.\fermata\resp
         \tempo 4 = 63
         e,4--^\markup\italic"rall." e-- e-- a2 g4 a2\fermata
         \bar"|."
       } \tonIIIaf
     }
     \new Voice = "alto"\with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c'
       { 
         e2 e4 e2. e4 f g a2. gis e4 e e d 
         \override BalloonText.annotation-balloon = ##f 
         <e \balloonText #'(1.5 . -2)\markup { "" } >2
         e
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je suis là et je t’ap -- pel -- le,
     et tu ré -- ponds, mon Dieu_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 b4 c2. c4 c b a2. b c4 b a a 
          \override BalloonText.annotation-balloon = ##f 
          <b \balloonText #'(1.5 . 2)\markup { "" } >2
          a
        } \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 e4 a2. a4-> a g f2. e\fermata\resp
          a4-- g-- f-- f-- e2 <a, e'>\fermata
        } 
      }
   >>
>>