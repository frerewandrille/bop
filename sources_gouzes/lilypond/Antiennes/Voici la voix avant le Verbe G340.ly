\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/4 }
resp = { \breathe\allowBreak }


\transpose g f
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 63
         g4 a-> b4 2. c4 a-> c b2 b2.\resp g4 g-> a4 2. 4 b-> a g2 2.\resp
         b4 b-> a b2 g4->^\markup\italic"élargir" g e2 g4-> f g-> f! e1\fermata
         \bar"|."
       } \tonIIImf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g4 a b fis2. g4 g g fis2 2. e4 e e fis2. 4 4 4 e2 2. 4 4 fis g2 e4 e4 2 4 d e d e1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci la voix a -- vant le Ver -- be_! Voi -- ci la lampe a -- vant l’au -- ro -- re_! 
     L’a -- mi est là et l’É -- poux va bien -- tôt ve -- nir_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 a b d2. e4 c e d2 2. 4 4 c d2. 4 4 4 b2 2. 4 4 4 2 4 4 c2 b4 c b c b1
        } \tonIIImh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 a-> b g2. 4 g-> a b2 2.\resp 4 4 a d,2. 4 d-> d e2 2.\resp
          g4 fis4 4 e2 g4 4 a2 g4 a g a e1\fermata
        } 
      }
   >>
>>