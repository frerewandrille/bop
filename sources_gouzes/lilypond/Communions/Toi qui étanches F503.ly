\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         a2 4 4 4 4 c bes a2.\resp 4 g2 2 1\fermata\resp
         f\breve e4 f g1\resp 2 (a4) bes a1\fermata
         \bar"|."
       } \tonVIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f2 4 4 4 4 4 e f2. 4 2 2 e1 c\breve 4 4 1 e2 (f4) e f1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Toi qui é -- tan -- ches no -- tre soif, ô Dieu vi -- vant,
     "tu nous enivres" de ton sang. Gloire à toi_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 4 4 4 4 4 4 2. 4 2 b c1 a\breve g4 a bes1 c2. 4 1
        } \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 4 4 4 4 a g f2. \resp 4 g2 g c,1\fermata\resp
          f\breve c4 4 1\resp 2 (f4) g f1\fermata
        } 
      }
   >>
>>