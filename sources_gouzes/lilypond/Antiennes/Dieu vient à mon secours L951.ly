\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script 
         (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff
<< 
  \new Dynamics { 
    g2^\< g4 g bes^\> bes a4.\!
    a8^\< a4 a8 [g]\agauche f2^\>\rall f4 f a2\!
  }
  \new Staff \with {\remove Time_signature_engraver }
  << \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 4 = 72
         g2 g4 g bes bes a4.\resp
         a8 a4 a8 [g] f2 f4-- f-- a2\fermata
         \bar"|."
       } \tonVIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e2 e4 e f f f4. f8 f4 f8 [e] d2 d4 d f2
       }    
     }
  >>
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
  {
    Dieu vient à mon se -- cours_! Il est le sou -- tien de ma vie.
  }
  \new Staff \with {\remove Time_signature_engraver }
  << \new Voice = "ténor"
     { \voiceOne \relative c'
       { \clef "bass" \armure \cadenzaOn
         c2 c4 c d d c4. c8 c4 c8 [c] a2 bes4 bes c2
       } 
     }
     \new Voice = "basse"
     { \voiceTwo \relative c
       { 
         c2 c4 c bes bes f'4.\resp f8 f4 f8 [c] d2 bes4-- bes-- f'2\fermata
       } \tonVIah
     }
  >>
>>