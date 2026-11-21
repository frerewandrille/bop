\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \cadenzaOn 
          \tempo "Calme" 4 = 60
          g8 [g] g [g] fis4 fis8 [fis] a [a] g4 fis2\fermata\bar "|"
          fis8 [fis] g [g] a4 \allowBreak b8 [c] d4 d8 [d] c4 (b) b2\fermata\bar "|."
        } \tonVIff
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          d8 [d] d [d] d4 d8 [d] e [e] e4 dis2
          dis!8 [dis] e [e] fis4 g8 [g] g4 g8 [g] g2 g
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Qui8 ha -- bi -- te -- ra4 sous8 ta ten -- te, Sei4 -- gneur_?2
     Qui8 re -- po -- se -- ra4 sur8 ta sain 4 -- te8
     mon -- ta2 -- gne_?
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \cadenzaOn 
          b8 [b] b [b] a4 a8 [a] c [c] b4 b2
          b8 [b] b [b] d4 d8 [c] b4 b8 [b] c4 (d) d2
        }\tonVIfh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          g8 [g] g [g] d4 d8 [d] c [c] e4 b2\fermata
          b8 [b] e [e] d4 g8 [e] d4 d8 [d] e4 (g) g2\fermata
        }
      }
   >>
   
>>