\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key d \minor \cadenzaOn \tempo 2 = 72
          d,2 c4 d a' a b b a2 \breathe a4 a b!2 g4 g a2\fermata \breathe \allowBreak
          d^\markup\italic"élargir" d4 d c2\fermata a\fermata a\fermata  \bar "||" %\noBreak
        } \tonIbf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          d2 c4 d a' a g g e2 e4 e g2 e4 e e2 f f4 f g2 fis fis
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      Tout2 ce4 que vous de -- man -- de -- rez2 à4 mon Père2 en4 mon nom,2
      il vous4 l’ac -- cor2 -- de -- ra.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key d \minor \cadenzaOn 
          d,2 c4 d a' a d d cis2 cis4 cis d2 d4 d cis!2 
          d d4 d e2 d d
        }\tonIbh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          d2 c4 d a' a g g a2 \breathe a4 a g2 b4 b a2\fermata \breathe
          bes <bes, bes'>4 <bes bes'> <c c'>2\fermata <d d'>\fermata <d d'>\fermata
        }
      }
   >>
   
>>