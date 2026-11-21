\version "2.24.0"
% %\include "TonsDef.ly"
% \include "vowel-set.ly"
% \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2. = 69
         e4-> d e g2-> g4 c2 4 b-> (a) g a2. \resp
         2 b4^\markup\italic"élargir" 2. g4-> fis g a g a a2. a
         \bar"|."
       } \tonVIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 d e g2 4 e2 4 d (c) b d2. 2 dis4 2. b4 dis! e fis e e fis2. 2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pour no -- tre joie, tu es res -- sus -- ci -- té, 
     et la nuit com -- me le jour il -- lu -- mi -- ne_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 d e g2 4 2 4 4 (fis) g fis2. 2 4 2. g4 b b d! b c d2. d
        } \tonVIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> d e g2-> 4 c,2 4 g-> (d') e d2. \resp
          d2 b4 2. e4-> b e d! e a, d2. d
        } 
      }
   >>
>>