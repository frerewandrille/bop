\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

rall = #(make-dynamic-script
         (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0
armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose f e
\new ChoirStaff
<< \new Dynamics 
   {
     f2 d4 f g\resp
     g\breve*1/16 f4 g bes\resp 
     bes\breve*1/16^\< bes2\! c4 bes a2\resp
     bes4^\< c d\breve*1/16 
     ees4^\> d d2 (c4 bes) c2\!\resp
     c\breve*1/16 d4 \agauche bes2.\rall^\> bes4 g g f2\!
     \bar"|."
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f2 d4 f g\fermata\resp
         g\breve*1/16 f4 g bes\resp 
         bes\breve*1/16^\markup{\italic accel.} bes2\! c4 \allowBreak bes a2\resp
         bes4^\markup{\italic accel.} c 
         d\breve*1/16 ees4 d d2 (c4 bes) c2\fermata\resp
         c\breve*1/16  d4 bes2. bes4 g g f2\!\fermata
         \bar"|."
       } \tonVIIIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c2 d4 c ees ees\breve*1/16 ees4 ees f f\breve*1/16
         f2 f4 f f2 f4 f bes\breve*1/16 bes4 bes bes2 (a4 g) a2
         a\breve*1/16 s4 g2. g4 ees ees c2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     D’un grand dé -- sir, "Dominique a" dé -- si -- ré
     "que tous les peuples te" cher -- chent, Sei -- gneur,
     et te "chantent d’un cœur" u -- na -- ni -- me
     "dans l’u" -- ni -- té de ton Es -- prit.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 bes4 a bes bes\breve*1/16 c4 c d d\breve*1/16
          d2 ees4 d c2 d4 ees f\breve*1/16 g4 f f2. (d4) f2
          f\breve*1/16 s4 d2. d4 bes c a2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 f ees\fermata\resp
          ees\breve*1/16 ees4 ees <bes bes'>\resp
          bes'\breve*1/16 bes2 a4 bes f2\resp
          bes4 bes bes\breve*1/16 ees,4 bes' bes2 (f4 g) f2\fermata\resp
          f\breve*1/16 s4 g2. g4 g ees f2\fermata
        } \tonVIIIgh
      }
   >>
>>