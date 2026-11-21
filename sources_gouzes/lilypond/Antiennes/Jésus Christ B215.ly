\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          a\breve*1/8 a4\resp bes8 [a] a [g] a2\resp 
          c\breve*1/8 c8 ([d c~] c [bes] c4) a4. 
          \allowBreak a8 a [g] a2\fermata
          \bar"|."
        } \tonVIhf %ton à quatre stiques dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f\breve*1/8 f4 f8 [f] f [e] f2 
          a\breve*1/8 a8 ([bes a~] a [g] a4) f4.
          f8 f [e] f2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Jésus Christ, mort pour nos pé -- chés, 
      "mets en nos cœurs l’allé" -- gres -- se de ton sa -- lut_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c\breve*1/8 c4 d8 [c] d [d] c2
          f\breve*1/8 f4. (d4 <c f>) c4. c8 d [d] c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/8 f4\resp f8 [f] bes [bes] f2\resp
          f\breve*1/8 f4. (bes4 f) f4. 
          f8 bes [bes] f2\fermata
        } \tonVIhh
      }
   >>
>>