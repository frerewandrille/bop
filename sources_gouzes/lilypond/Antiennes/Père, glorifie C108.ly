\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 2/4 \cadenzaOn \tempo "Large et paisible" 2 = 52
          bes2. g4 bes^> c d^> bes bes2.\breathe\allowBreak 
          bes4 g^> a! g2. f4 f^> g g2 \fermata  \bar "|." %\noBreak
        } \tonVaf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          g'2. ees4 g aes f f g2. g4 ees c ees2. 
          c4 d ees ees2
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano" %\override LyricText.font-size = #3
      Pè2. re,4 glo -- ri -- fie ton Fils,2. pour4 que ton Fils2. te4 glo -- ri -- fie.2
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 2/4 \cadenzaOn 
          ees2. bes4 ees ees d d ees2. ees4 bes a! bes2. 
          a!4 a bes bes2
        }\tonVah
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          ees2. ees4 ees_> aes bes_> bes ees,2.\breathe 
          ees4 ees_> f ees2. f4 f_> ees ees2\fermata
        }
      }
   >>
   
>>