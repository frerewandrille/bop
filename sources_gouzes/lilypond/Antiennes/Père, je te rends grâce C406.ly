\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo "Très calme, paisible" 2 = 42
          a2 (c4) a2. a4^> a a a2 (g4) a2.\bar "|" \time 2/4 
          a4 a f2  f g g \fermata \!  \bar "||" %\noBreak
        } \tonVIcf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          f2 (e4) fis2. fis4 fis fis e2. e
          e4 e d2 d e e
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      Pè2. -- re, je4 te rends grâ2. -- ce de4 m’a -- voir2 ex -- au -- cé_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn 
          c2. d d4 d d c2 (d4) cis2. cis!4 cis a2 a c c
        }\tonVIch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          f2 (a4) d,2. d4_> d d a'2 (b4) a2. \time 2/4 
          a4 a d,2 d c c\fermata
        }
      }
   >>
   
>>