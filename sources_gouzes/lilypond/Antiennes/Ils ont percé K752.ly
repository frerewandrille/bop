\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     g2^\< g4 g g g g1^\> g2 f g2.\!
          g4^\< a bes g2^\> g a a1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 54
          g2 g4 g g g g1 g2 f g2.\fermata\resp
          g4 a bes g2 g a a1\fermata
          \bar"|."
        } \transpose g bes \tonIIif
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d4 d ees ees c1 d2 d d2. d4 d d ees2 c c d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ils ont per -- cé mes mains et mes pieds. 
      Je peux comp -- ter tous mes os_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 bes4 bes bes bes g1 a2 a bes2. bes4 bes bes bes2 g g fis1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 f4 f ees ees ees1 d2 d g2.\fermata\resp 
          g4 f f ees2 ees ees d1\fermata
        } \transpose g bes \tonIIih
      }
   >>
>>