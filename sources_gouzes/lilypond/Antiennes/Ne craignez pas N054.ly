\version "2.24.0"
% %\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }


\transpose g f
\new ChoirStaff
<< \new Dynamics 
   {
     
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" %2 = 52
         g4-> a fis g2.\fermata \silN 
         b4 c d2. d4-> d d d-> (c) b a2.\fermata\bar"|"
         a4-> a a b-> b b g-> fis g a2.\resp
         d4-> e e d2-> d4 d2-> d4 b2.\fermata
         \bar"|."
       } \transpose a b \tonVIdf % Sans ton dans l’original
     }
     \new Voice = "alto" 
      { \voiceTwo \relative c'
       { 
         d4 d d d2. s4 g g g2. g4 g g g (fis) g fis2.
         fis4 fis fis fis fis fis e dis e fis2. g4 g g g2 g4 fis2 fis4 g2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ne crai -- gnez pas_!
     Je m’en vais, mais je re -- viens vers vous_!
     Je ne vous lais -- se -- rai pas or -- phe -- lins,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 c c b2. \silN d4 d d2. d4 d c d2 d4 d2. 
          d4 d d b b b b b b d2. b4 c c a2 a4 a2 a4 g2.          
        } \transpose a b \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4-> fis a g2.\fermata s4 g a b2. b4-> b c b (a) g d2.\fermata
          d4-> d d dis-> dis dis e-> b' e, d2.\resp
          g4-> c, c d2-> d4 d2-> d4 <g, g'>2.\fermata
        } 
      }
   >>
>>