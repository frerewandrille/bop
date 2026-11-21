\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo "Paisible et allant"% 2 = 52
          a4 a g2-> a4 f-> f f c'2 c4 a4\fermata\breathe\allowBreak 
          a a d-> d d c \allowBreak c c f,-> f g a2.\bar"|"
          a4-> a a g2 g4 bes2 bes4 a2.\fermata\breathe\allowBreak  
          f4-> f f f2\breathe\allowBreak f4 f2 g4 a2.\fermata\bar "|."
        }\transpose b a \tonVIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f e2 e4 d d d g2 g4 f f f f f g a a a f f e f2.
          f4 f f d2 d4 d2 e4 f2. d4 d d d2 d4 d2 e4 d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     De -- meu -- rez tou -- jours les a -- mies de Dieu, 
     les a -- mies de vos cœurs et de tou -- tes vos sœurs.
     Vi -- vez en gran -- de pau -- vre -- té, 
     dans la dou -- ceur de son a -- mour.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          c4 c c2 c4 a a a c2 c4 c c c d d d e e e d d bes c2.
          c4 c c bes2 bes4 bes2 bes4 d2. a4 a a a2 a4 bes2 bes4 c2.
        }\transpose b a \tonVIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f c2-> c4 d-> d d e2 e4 f\fermata\breathe f f bes-> bes bes a a a bes-> bes g f2.\fermata
          f4-> f f g2 g4 g2 g4 d2.\fermata\breathe d4-> d d d2\breathe d4 g2 g4 f2.\fermata
        }
      }
   >>
>>