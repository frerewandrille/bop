\version "2.24.0"
%\include "TonsDef.ly"

\transpose c bes,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn \tempo "Léger" 2 = 54
          c4 (a) a2\fermata \breathe \allowBreak a4 c c2 (a4 b) a2 \breathe \allowBreak
          c4^> b c^> d d2 c4 d d2\fermata \breathe \allowBreak
          c2 a4^> c b2. d4 c2 c b\fermata \bar "|."
        }
        \tonIIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          a2 fis fis4 fis g1 fis2 g4 g g g fis2 g4 g fis2
          g2 g4 g fis2. fis4 g2 a g
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      Pè2 -- re, je4 m’é -- veil1 -- le,2 et4 je suis en -- core2 a4 -- vec toi.2
      Tu as4 po -- sé2. ta4 main2 sur moi_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
          e2 d d4 d e1 d2 e4 e e e d2 e4 e d2
          e e4 e d2. d4 e2 e e
        }
        \tonIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          a2 d,\fermata \breathe d4 d a'2 (c) d \breathe
          a4_> b a_> a d,2 a'4 a d2\fermata \breathe
          a c4_> c d2. d4 a2 a e\fermata
        }
      }
   >>
>>