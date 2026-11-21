\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 2/4 }
resp = { \breathe\allowBreak }


\transpose g f
\new ChoirStaff
<< \new Staff = "femmes"
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 63
         g4 a-> b b2. c4 a-> c b2.\resp 
         g4 g-> a a2. a4 b-> a g2.\resp
         b4 b-> a b2 g4-> g e2.\resp
         g4 g-> f g-> a g2 g4-> f! g-> f! e1\fermata
         \bar"|."
       } \tonIIImf
     }
     \new Voice = "alto"
      { \voiceTwo \relative c''
       { 
         g4 a b fis2. g4 g g fis2. e4 e e fis2. fis4 fis fis e2.
         e4 e fis g2 e4 e e2. e4 e d e f! e2 e4 d e d e1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci ve -- nir l’A -- gneau de Dieu_!
     Tou -- te val -- lée se -- ra com -- blée,
     tou -- te col -- line a -- bais -- sée,
     et tou -- te chair ver -- ra le sa -- lut de Dieu_!
   }
   \new Staff = "hommes"
   << \new Voice = "ténor"
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 a b d2. e4 c e d2. d4 d c d2. d4 d d b2.
          b4 b b b2 b4 b c2. b4 b c b a b2 b4 c b c b1
        } \tonIIImh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 a-> b g2. g4 g-> a b2.\resp
          b4 b-> a d,2. d4 d-> d e2.\resp
          g4 fis-> fis e2 g4-> g a2.\resp
          g4 g-> a g-> f g2 g4-> a g-> a e1\fermata
        } 
      }
   >>
>>