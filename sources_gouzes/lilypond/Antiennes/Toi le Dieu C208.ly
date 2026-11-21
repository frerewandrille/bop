\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Marqué" 2. = 58
         c2 c4 a2. c4-> d c c2. a2\fermata\resp
         a4 a-> a a g2-> a4 f2-> f4\resp 
         a2--->^\markup\italic"rall."
         b4-- b---> a-- g-- a2.--\fermata
         \bar"|."
       } \tonVbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         a2 a4 f2. f4 f f f2. f2 f4 f e d d (e) f d2 d4 f2 f4 f f e f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Toi; le Dieu qui fait mer -- veil -- le,
     tu as bap -- ti -- sé ton peu -- ple par le feu et par l’eau.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 e2 (d4) c b a e' (d c) d2 d4 c c c b2 c4 c2 c4
          e (d) d e d b c2.
        } \tonVbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 f2. a4-> g f f2 (a4) f2\fermata\resp
          f4 f-> f f g2-> f4 a2-> a4\resp 
          a2---> a4-- g---> a-- <d, d'>-- <f, f'>2.--\fermata
        } 
      }
   >>
>>