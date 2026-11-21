\version "2.24.0"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
large = #(make-dynamic-script 
         (markup #:line ( #:normal-text #:italic "élargir." )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme"% 2 = 69
         \repeat volta 3 {
           a4 a a a2\fermata\resp 
           a4 a a a a a g a bes2 (a4) a2\resp
         }
         \alternative {
           { a4 \agauche f\large^\> g2 a a1\fermata\! }
           { a4 \agauche a\large^\> f2 g a1\fermata\! }
         }
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \repeat volta 3 {
           f4 f f f2 f4 f f f f f e f g2 (e4) f2
         }
         \alternative {
           { f4 d e2 e f1 }
           { f4 f d2 e e1 }
         }        
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     A -- gneau de Dieu, 
     qui en -- lè -- ves les pé -- chés du mon -- de,
     %\set stanza = "1 & 2. " 
     prends pi -- tié de nous.
     %\set stanza = "3. " 
     don -- ne_- nous la paix.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \repeat volta 3 {
            d4 d d d2 d4 d d d d d d d d2 (cis4) d2
          }
          \alternative {
            { d4 a c2 cis d1 }
            { d4 d a2 c cis1 }
          }
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \repeat volta 3 {
            d4 d d d2\fermata\resp 
            d4 d d d d d d d g2 (a4) d,2\resp
          }
          \alternative {
            { d4 d c2 a d1\fermata\! }
            { d4 d d2\fermata c\fermata a1\fermata }
          }
        } 
      }
   >>
>>