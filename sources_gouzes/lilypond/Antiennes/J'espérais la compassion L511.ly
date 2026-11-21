\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Dynamics 
   {
          a2^\< a d2. d4 d d cis1\! \breathe 
          a2^\pp^\> a c!1\!
          a4^\< a a2.\! \allowBreak a4 a a a1^\> a2 gis a1 a\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 2/2 \cadenzaOn \tempo 2 = 60
          a2 a d2. d4 d d cis1\fermata \breathe 
          a2 a c!1\fermata \bar "|" \tempo "Vif"
          a4 a a2. \allowBreak a4 a a a1 a2 gis a1\fermata a\fermata \!
          \bar "|."
        } \tonIVgf 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          a2 a f2. f4 g g a1 f2 f e1 e4 e e2. e4 e e f1 e2 e e1 e
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      J’es2 -- pé -- rais2. la4 com -- pas -- sion,1 mais2 en vain.1
      Dans4 ma soif,2. ils4 m’ont don -- né1 du2 vi -- nai1 -- gre.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 2/2 \cadenzaOn
          f2 e d2. d4 d d e1 d2 a a1 a4 a a2. a4 a a a2. (b!4) c2 b c1 c
        }\tonIVgh 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d2 c bes2. bes4 bes bes a1\fermata \breathe d,2 d a1\fermata
          c4 c c2. c4 c c d1 c2 e a,1\fermata a\fermata
        }
      }
   >>
>>