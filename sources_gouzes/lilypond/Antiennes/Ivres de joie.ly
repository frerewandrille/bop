\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose g f
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 4 = 72
          d8 [g a] b4.\resp d8 [c b] a4 g8 fis4\resp
          b8 a4 g8 g4 fis8 g4.\fermata
          \bar"|."
        } \transpose f g \tonVIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d8 [e g] fis4. g8 [g g] g4 e8 dis4 d8 e4 e8 e4 d8 d4.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      I -- vres de joie, vous pui -- se -- rez les eaux
      aux sour -- ces du sa -- lut.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 [b e] d4. b8 [c d] e4 b8 b4 b8 c4 b8 c4 a8 b4.
        } \transpose f g \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g16 [(fis) e (d) c8] b4.\resp
          g'8 [e d] c [(d) e] b4\resp g'8 c,4 e8 a4 d,8 g4.\fermata
        } 
      }
   >>
>>