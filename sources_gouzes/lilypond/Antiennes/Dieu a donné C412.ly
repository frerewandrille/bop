\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose c bes,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Très vif" 2. = 72
          a4-> g a c-> b c d-> c b a2.\fermata\resp
          a4-> g a b2. b \resp a4->^\markup\italic"élargir"
          g a b-> a g a1\fermata
          \bar"|."
        } \transpose bes c' \tonVdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 e f f f f e f g a2. f4 e f g2. g f4 e f g f e f1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Dieu a don -- né le sa -- lut à son Christ_:
      Heu -- reux le peu -- ple que le Sei -- gneur a bé -- ni_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 b c c d c b c d <c f>2.
          c4 d c d2. d d4 d c d c d c1
        } \transpose bes c' \tonVdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4-> g f a-> a a g-> a g f2.\fermata\resp
          a4-> b a g2. g\resp c4-> b a g-> a b f1\fermata
        } 
      }
   >>
>>