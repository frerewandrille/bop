\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         bes8\rest [f8 f] f4 (d8 [c] f [g] a [bes] a [g]) a4\fermata\bar"|"
         a4 a8 [a] a [c] a [g] a4\fermata\resp
         a8 [a] a4\resp a8 [bes] g4\resp g8 [a] f4\fermata
         \bar"|."
       } \transpose g f \tonVIif
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         bes8\rest [c8 c] d4 (bes c d e) f
         f4 f8 [f] f [e] f [d16 (e)] f4 8 [f] e4 8 [e] d4 8 [e] c4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Je suis l’Al -- pha et l’O -- mé -- ga, 
     le Pre -- mier, le Der -- nier, le Vi -- vant_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c8\rest [a8 a] bes4 (g a bes c) c
          c4 c8 [c] d [d] c [bes] c4 8 [c] 4 8 [c] bes4 8 [c] a4
        } \transpose g f \tonVIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*13/16 f4\fermata
          f f8 [f] bes [8] f [g] f4\fermata\resp
          8 [f] c4\resp 8 [c] d4\resp 8 [c] f4\fermata
        } 
      }
   >>
>>