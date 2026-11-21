\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose a g
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         a\breve*1/8 4\resp bes8 [a] a [g] a2\resp
         c\breve \allowBreak 8 ([d c~] c [bes] c4) a4. 8 8 [g] a2\fermata         
         \bar"|."
       } \tonVIhf % à quatre stiques dans l'orig.
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f\breve*1/8 4 8 [f] f [e] f2 
         a\breve a8 ([bes a~] a [g] a4) f4. 8 f [e] f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Jésus Christ, mort pour nos pé -- chés,
     "mets en nos cœurs l’allé" -- gres -- se de ton Sa -- lut_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c\breve*1/8 4 d8 [c] d [d] c2 
          f\breve 4. (d4 <c f>) c4. 8 d [d] c2
        } \tonVIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/8 4\resp 8 [f] bes [8] f2\resp
          \breve 4. (bes4 f4) 4. 8 bes [8] f2\fermata
        } 
      }
   >>
>>