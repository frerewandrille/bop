\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     bes4 bes2. d4 c2 bes bes (a4 g) a2. 
     \tempo "Vif" a4^\< bes2 bes4 a\! bes c d2 d4^\> d d2 (c) bes2.\!\resp 
     bes4^\< a2\! a^\> g1\!
     \bar"|."
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \accidentalStyle neo-modern-voice
      \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 84
          bes4 bes2. d4 c2 bes bes (a4 g) a2.\fermata\resp 
          \tempo "Vif" a4 bes2 bes4-> a bes-> c d2 d4 d d2 (c) bes2.\resp 
          bes4 a2 a g1\fermata
          \bar"|."
        } \tonIIhf % Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g2. g4 fis2 g g (fis!4 e) d2. 
          fis!4 g2 g4 fis g a bes2 bes4 bes a1 g2. g4 g2 fis! d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Christ, a -- mi des hom -- mes, 
     tu es la ré -- sur -- rec -- tion et la vi -- e_! 
     Nous t’a -- do -- rons_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \accidentalStyle neo-modern-voice
      \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d2. d4 d2 d d2. (e4) fis2.
          d4 d2 d4 d d f! f2 f4 f d1 d2. d4 ees2 d4 (c) bes1
        } \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g2. bes4 a2 g d'1 d,2.\fermata\resp
          d4 g2 g4-> d g-> f bes2 bes4 bes fis1 g2.\resp
          g4 c,2 d <g, g'>1\fermata
        } 
      }
   >>
>>