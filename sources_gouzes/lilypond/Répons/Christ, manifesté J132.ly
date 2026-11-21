\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Lent, bien scandé" 2. = 44
         d2. 4 e d c2. f,2 g4 a2.\resp d2. 4 (e) d c2 4 f,2 g4 a2.\resp
         g2 (a8) [g] f2 4 e2 4 d2. \resp d c d
         \bar"|."
       } \tonIef
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f2. 4 g f e2. d2 4 f2. f f4 (g) f e2 4 d2 4 f2.
         e2 (f8) [e] d2 4 c2 4 bes2 (g4) a2. a a
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Christ, ma -- ni -- fes -- té dans la chair,
     Christ, pro -- cla -- mé chez les paï -- ens, gloire à toi, Sei -- gneur Jé -- sus,
     gloire à toi_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2. 4 4 4 2. d2 4 c2. a a2 4 2 4 d2 4 c2.
          c2 ~ 8 [c] a2 4 2 4 f2. f e2 (g4) f2.
        } \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2. 4 4 4 a'2. bes2 4 f2.\resp d d2 4 a'2 4 bes2 4 f2.\resp
          c2 ~ c8 [c] d2 4 a2 4 bes2.\resp f2 (g4) a2. d
        } 
      }
   >>
>>