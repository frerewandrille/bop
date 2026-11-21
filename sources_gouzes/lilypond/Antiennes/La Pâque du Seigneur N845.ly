\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         ees8 f ([ees]) f ([g]) g4.\fermata\bar"|"
         g8 bes [a] f [a] a4\resp a8 [bes] g4 f8 [g] ees4\fermata\resp
         f4 (g8) [g] f4 f\fermata
         \bar"|."
       } \transpose c bes, \tonVIIIdf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         c8 d ([c]) d ([ees]) 4. 8 d [f] d [f] 4 
         8 [d] ees4 d8 [d] c4 d (ees8) [d] c4 c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! 
     La Pâ -- que du Sei -- gneur nous ar -- rache à la mort_! 
     Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes8 a [(bes)] a [(bes)] 4. 8 8 [c] c [c] c4 8 [bes] c4 8 [8] bes4
          a4 (bes8) [8] 4 a
        } \transpose c bes, \tonVIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 f [(g)] f [(ees)] 4.\fermata
          8 g [f] a [f] f4\resp 8 [g] c ([bes]) a [a] g4\fermata\resp
          f (ees8) [8] f4 f\fermata
        } 
      }
   >>
>>