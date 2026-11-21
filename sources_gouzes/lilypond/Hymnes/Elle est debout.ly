\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }	
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key f \major \cadenzaOn \tempo "Dramatique et lent"
          f2 g4 a g2 a c4 bes a2 \breathe \allowBreak a g4 f e2 d e4 d c1 \breathe \allowBreak 
          g'4 f g2 a g4 f f1 \fermata \bar "|." 
          f \breve g4 a g2 \breathe \allowBreak a \breve c4 bes a2 \bar "|" 
          a \breve f4 g a2 \breathe \allowBreak a \breve g4 f g2 \fermata \bar "||"
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        {
          c2 e4 e d2 e d4 e f2 f e4 d c2 bes bes4 bes a1 d4 d e2 e d4 d c1
          c \breve c4 f e2 f \breve e4 e f2 f \breve c4 c f2 f \breve c4 c e2
      } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode { 
     \set associatedVoice = #"soprano" 
     Elle2 est4 de -- bout,2 près de4 la Croix,2 
     seule, au4 plus haut2 de la4 dou -- leur,1 
     a4 -- do -- rant2 son Dieu4 qui meurt.1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key f \major \cadenzaOn
          a2 c4 a bes2 c bes4 bes c2 c c4 a a2 f g4 g e1 g4 a c2 c bes4 bes a1
          a \breve bes4 c bes2 c \breve c4 c c2 c \breve a4 bes c2 c \breve bes4 a bes2
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        {
          f2 c4 c bes2 a g4 g f2 \breathe f' c4 d a2 bes g4 g a1 \breathe bes4 d c2 a bes4 bes f'1 \fermata
          f \breve f4 f c2 \breathe f \breve a4 g f2 f \breve f4 f f2 \breathe f \breve f4 f c2\fermata
      } }
   >>
>>