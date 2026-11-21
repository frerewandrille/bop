\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 4/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   << \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \revert Staff.TimeSignature.style \armure
         \partial2 a4 a bes4. 8 g4 g a2 f \breathe a4 c d4 8 8 c2 bes4 a g2. \breathe
         r4 a g8 a bes4. a8 g4 f8^\markup\italic"rall." (g) a2~ \noBreak a\fermata
         \bar"|."
       } \cadenzaOn \transpose b a \tonVIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4 4 4. 8 4 e f2 c f4 f f d8 e f2 d8 (e) f4 e2. r4 f e8 f g4. f8 d4 d8 (e) f2~ f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Jé -- sus, a -- mi des hom -- mes,
     bé -- nie soit ta ve -- nue par -- mi nous, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \revert Staff.TimeSignature.style \armure 
          c4 c d4. 8 4 c c2 a c4 a bes4 8 8 a2 bes4 c c2. r4 c4 8 8 d4. c8 bes4 a8 (bes) c2~ c
        } \cadenzaOn \transpose b a \tonVIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 4 bes,4. 8 4 c f2 f\breathe 4 4 bes,4 8 8 f'2 g4 f <c c'>2. \breathe
          r4 f4 c8 f bes,4. f'8 g4 d8 (g) f2~ f\fermata
        } 
      }
   >>
>>