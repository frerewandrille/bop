\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose f ees
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8 [g a] a4 (c8 [b a] c4 d8 [e] c4\fermata a\fermata)\bar"|"
         c8 [b] a4.\fermata \allowBreak c8 d [e] c4.\fermata\resp
         8 b [c] a4.\fermata\allowBreak  8 g [a] b4 (a) g\fermata a\fermata
         \bar"|."
       } \tonVbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f8 [ f f] f4~ (f8 [g a] f2 a8 [g] f4)
         a8 [g] f4. a8 b [c] a4. 8 g [g] f4. 8 e [f] e ([d] c [d]) e4 f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Jé -- sus Christ, le Pre -- mier_- Né,
     nous fait en -- trer dans le re -- pos de Dieu.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          f8 [e d] 4~ (4.~ 4 b c d) d8 [d] d4. 8 d [c] d4. 8 d [d] d4. 
          8 d [c] b4 (c) b c
        } \tonVbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 [f f] 4 (a8 [b c] a4 g4 f\fermata f\fermata)
          a8 [b] c4.\fermata a8 g [g] f4.\fermata\resp
          a8 b [b] c4. 8 b [a] g4 (a) g\fermata f\fermata
        } 
      }
   >>
>>