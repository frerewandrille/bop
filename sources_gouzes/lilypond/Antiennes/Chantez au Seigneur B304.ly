\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key d \minor \time 1/4 }
resp = { \breathe }
barre = { \undo \omit Score.BarLine }
barress = { \omit Score.BarLine }
silC = { \oneVoice r8 \voiceOne }


\transpose d b,
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo  8 = 144
          \barress
          \silC a16 (d) d8 d16 c d8 d16 f f e d c d8 (a) a \resp
          a16 (d) d8 c d16 f (e d) c8 c \noBreak d2         
          \barre
          \bar "|."
        }\cadenzaOn \tonIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          s8 d16 (e) f8 f16 e f8 f16 g a g f e f8 (e) d\resp
          d16 (e) f8 e f16 a (g f) e8 <e g> <d a'>2
        }          
      }
   >>
   \new Lyrics \lyricsto "soprano"
   { 
     Chan -- tez au Sei -- gneur, 
     car il a fait des mer -- veil -- les.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          d8. (c16) d8. (e16) d8. c16 d8 d16 f f e d c d8 (a) a \resp
          a16 d d8 (c a c) <a d>2
        }\cadenzaOn \tonIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          d4 a' d8. c16 a8 f16 g a g f e f8 (e) d \resp
          d16 e f8 (a c a) d,2
        }
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" } 
   { \lyricsto "ténor" {
     Chan -- tez au Sei -- gneur, 
     car il a fait des mer -- veil -- les.
     Al -- lé -- lu -- ia_!   }
   }
>>