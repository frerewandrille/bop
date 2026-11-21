\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e b,
\new ChoirStaff
<< 
  \new Staff = "femmes" \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Large"
         e4 a b c c b\resp c8 [b] a4 (g) a2\resp 
         b8 ([c]) d4 e8 ([d]) c ([b]) a ([g]) a2\fermata
         \bar"|."
       } \tonIIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 e e a a e a8 [e] 2 2 8 ([a]) 4 4 4 e e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Les temps sont ac -- com -- plis_: le Sei -- gneur vient_!
     Ve -- nez, a -- do -- rons_- le_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 c' d e e d e8 [d] c4 (b) c2 d8 ([e]) f4 g8 ([f]) e ([d]) c ([b]) c2
        } \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 a a a a a\resp a8 [a] e2 a\resp a4 a a a a8 ([e]) a2\fermata
        } 
      }
   >>
>>