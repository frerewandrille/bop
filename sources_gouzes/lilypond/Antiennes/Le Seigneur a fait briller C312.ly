\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Doux et joyeux" 2 = 66
         f4 g g2. g4 a bes a2 g4 f g2 g4 f g2\fermata\resp
         g4 bes bes2. bes4 c c bes2 ( g f4) g\fermata g2\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d d2. e4 f f f2 d4 d e2 e4 d d2 e4 g g2. g4 g g g2 (e d4) e d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur a fait bril -- ler la lu -- miè -- re du Christ,
     et nos cœurs ont ju -- bi -- lé de joie.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 bes bes2. c4 c d c2 bes4 a c2 c4 a bes2 c4 d d2. d4 e e d2 (c2.) c4 bes2
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 g g2. c,4 f bes, f'2 g4 d c2 c4 d g2\fermata\resp
          c,4 g' g2. g4 c, c g'2 (c,2.) c4\fermata g'2\fermata
        } 
      }
   >>
>>