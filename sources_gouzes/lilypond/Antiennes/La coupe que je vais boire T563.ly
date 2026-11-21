\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Dynamics 
   {
     
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 54
         e4 e2 e4 e e fis g2 (fis) e2\fermata\resp
         \silN e4 g2 a b1\fermata\bar"|"
         b4 b d d b2 b4 b a2 a4 b g2 (a) b1\fermata
         \bar"|."
       } \tonIIIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         b4 b2 b4 b b b b (e2 dis4) e2 s4 c b2 d d1
         d4 d fis fis g2 g4 g fis2 fis4 fis e1 dis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La cou -- pe que je vais boi -- re, vous la boi -- rez_;
     et vous ré -- gne -- rez a -- vec moi dans la gloi -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 g2 g4 g g fis e (b'2 a4) g2 \silN a4 g2 g4 (fis) g1
          g4 g a a g2 g4 b d2 d4 d b2 (a) fis1
        } \tonIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 e2 e4 e e dis e (g, b2) e\fermata\resp
          s4 a, e'2 d g,1\fermata
          g4 g d' d g2 g4 g d2 d4 d e2 (c) b1\fermata
        } 
      }
   >>
>>