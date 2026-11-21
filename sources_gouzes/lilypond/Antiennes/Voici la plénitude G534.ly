\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très calme" 2 = 48
         a2 a2. a4 d d c2 f,4 g a2\fermata\resp
         a2 a2. a4 bes bes a2 f4 g a2 a\fermata
         \bar"|."
       } \tonVIof
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f2 f2. f4 f g a2 d,4 e f2 f f2. f4 f f f2 d4 e f2 f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci la plé -- ni -- tu -- de des temps, 
     où Dieu en -- voie son Fils sur la ter -- re.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c2. c4 d d e2 d4 d c2 c c2. c4 d d c2 d4 bes c2 c
        } \tonVIoh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f2. f4 bes bes a2 bes4 bes f2\fermata\resp
          f f2. f4 f f f2 bes4 g f2 f\fermata
        } 
      }
   >>
>>