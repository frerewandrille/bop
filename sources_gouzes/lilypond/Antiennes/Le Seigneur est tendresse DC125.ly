\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large"% 2 = 52
         g2 a4 bes-> a g a-> g f g2.\resp
         bes c4-> d c bes-> (a) g a (g) f g2.\fermata
         \bar"|."
       } \tonIIhf
       %\transpose g bes \tonIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 e4 f e! d e! d d d2. g a4 bes a g (f) d e!2 d4 d2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
    Le Sei -- gneur est ten -- dresse et pi -- tié,
    lent à la co -- lère et plein d’a -- mour.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 c4 d-> c bes c-> bes a bes2. 
          d e4-> f e d-> (c) bes c (bes) a bes2.
        } \tonIIhh
        %\transpose g bes \tonIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 g2. c,2 d4 g2. \resp
          g2 g4 g2 g4 g2 g4 c,2 d4 g2.\fermata
        } 
      }
   >>
   \new Lyrics \lyricsto "basse"
   {
    Le Sei -- gneur est pi -- tié,
    lent à la co -- lère et plein d’a -- mour.
   }
>>