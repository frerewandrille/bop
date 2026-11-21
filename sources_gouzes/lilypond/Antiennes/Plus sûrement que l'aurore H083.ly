\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 6/8 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure %\tempo "" 2. = 50
          \revert Staff.TimeSignature.style
          \partial8 e8 a (b) c b a a g4. e~ e8 e [e] a4. a8 b c b a a g4.
          \silN g8 f e d f e d c4 (d8) e4 e8 a b c a4 g8 a4. a
          \bar "|."
        }\cadenzaOn \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial8 e8 c (d) e d c c b4. c~ c8 c [c] c4. c8 d e f f e d4.
          s4 g8 f e d f e d c4 (b8) a4 e'8 e e e f ([e]) d e4. e
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Plus sû -- re -- ment que l’au -- ro -- re, 
      Is -- ra -- ël a at -- ten -- du son Sei -- gneur.
      En lui est ca -- chée l’a -- bon -- dan -- ce 
      de tou -- te mi -- sé -- ri -- cor -- de.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          \partial8 e8 a4 a8 a a e g4. g~ g8 g [g] a4. a8 a a a a a b4. \silN
          g,8 a a b d e f e4 (d8) c4 e8 e e a a4 b8 c4. c
        }\cadenzaOn \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial8 e8 a,4 a8 a a a e'4 (d8) c4.~ c8 c [b] a4. 
          e'8 d c d d d g4.
          s4 g,8 a a b d e f e4 (d8) c4 c8 c b a d4 d8 a4. a
        }
      }
   >>
>>