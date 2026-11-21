\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose g f
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         g8 [g] a ([b a]) 4.\fermata\bar"|"
         \once\hide r8 [g g] fis4 g8 [e] d4.\fermata\resp
         g8 g [fis] a [a] b4.\fermata\bar"|" 8 b ([a]) a ([g]) g4\fermata
         \bar"|."
       } \transpose a b \tonVIdf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d8 [d] e4. fis r8 [e e] d4 e8 [c] a4. d8 e [d] e [fis] g4.
         8 fis4 e d
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Re -- ce -- vez l’Es -- prit Saint_!
     La paix soit a -- vec vous_! Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 [b] c4. d g,8\rest [b b] 4 8 [a16 (g)] fis4.
          b8 b [b] c [c] d4. 8 d ([c]) 4 b
        } \transpose a b \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [g] g4. d\fermata \once\hide r8 [e e] b4 e16 [(d) c8] d4.\fermata\resp
          g8 e [b'] a [a] g4.\fermata 8 d4 e g\fermata
        } 
      }
   >>
>>