\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn \tempo "Large et paisible" 2 = 60
          a4 g2. a4 a2. \breathe a4 a bes g2 g4 g a2. \breathe \allowBreak
          a4 g2. g4 f^> f e2 d\fermata \breathe \allowBreak 
          f2. e4 f2 \fermata  \bar "|." %\noBreak
        } \tonVIdf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          f4 e2. e4 f2. f4 f d d2 d4 e f2.
          f4 e2. e4 d d c2 bes bes (c4) c c2
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      Je4 suis2. la4 Voie,2. la4 Vé -- ri -- té2 et4 la Vie,2.
      et4 nul2. ne4 vient au Pè2 -- re que2. par4 moi.2
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn 
          c4 c2. c4 c2. c4 c bes bes2 bes4 bes c2.
          c4 c2. c4 a a a (g) f2 f (g4) g a2
        }\tonVIdh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          f4 c2. c4 f2. \breathe f4 f g g2 g4 g f2. \breathe
          f4 c2. c4 d_> d a2 bes\fermata \breathe d2 (c4) c f2\fermata
        }
      }
   >>
   
>>