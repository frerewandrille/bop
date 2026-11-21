\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Dansant"% 2 = 52
         \override Staff.Script.outside-staff-priority = #10
         f4-> g a-> f g-> g f-> f\resp bes-> c d-> bes c2 c \bar "|"
         f,4-> g a-> f g-> d f2\resp d^\markup\italic"rall."\fermata
         e\fermata f\fermata
         \bar"|."
       } \tonVIkf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c4 e f d d e c c d f f d e2 e
         c4 c a d d d c2 bes bes c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que les cieux se ré -- jou  -- is -- sent, 
     que la terre e -- xul -- te
     à la fa -- ce du Sei -- gneur, car il vient_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 c c bes bes c a a f a bes bes g2 g
          a4 g f a bes bes a2 f g a
        } \tonVIkh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4-> c f-> bes g-> c, f-> f\resp 
          bes,-> f' bes,-> g' c,2 c
          f4-> e d-> d8 ([c]) bes4-> g' f2\resp
          bes,4 (a) g2\fermata f\fermata
        } 
      }
   >>
>>