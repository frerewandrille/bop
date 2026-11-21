\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose b a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 88
         b8 b [b] g [b] b4 c8 [b] b4.\fermata\resp
         b8 [b] a4 a8 [b] g4 g\resp
         b8 [c] d [e] d ([c] d [c]) a4\resp c4 (b8 [c] d) [c] b4 b\fermata
         \bar"|."
       } \tonVIff
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g\breve*1/16 s s s s s s s s g4. g8 [g] g4 fis8 [fis] d4 d
         g\breve*1/16 s s s s s s s g4 g\breve*1/16 s s s s s g4 g         
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci ve -- nir le Roi, le Très_- Haut a -- vec gran -- de puis -- san -- ce,
     pour sau -- ver le peu -- ple, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 d [d] b [d] d4 e8 [d] d4. d8 [d] c4 c8 [d] b4 b
          d8 [e] f [g] f ([e] f [e]) c4 e (d8 [e] f!) [e] d4 d
        } \tonVIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
         g\breve*1/16 s s s s s s s s g4.\fermata \resp g8 [g] d4 d8 [d] g4 g\resp
         g\breve*1/16 s s s s s s s g4\resp g\breve*1/16 s s s s s g4 g                
        } 
      }
   >>
>>