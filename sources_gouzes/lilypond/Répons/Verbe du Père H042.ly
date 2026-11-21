\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \major \time 6/8 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure  \tempo "Paisible"
         e4 (b'8) g4 a8 b4. b e,4 (fis8) g4 fis8 e2.
         e4 (b'8) g4 a8 b4. b e,4 fis8 g4 fis8 \noBreak e2.
         \bar"|."
       } \cadenzaOn \transpose a b \tonIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4^\ppp (g8) e4 fis8 g4. g e d4 8 e2.
         e4^\mf (g8) e4 fis8 g4. g e4 e8 d4 8 e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ver -- be du Pè -- re, nous t'a -- do -- rons.
     Ô Fils U -- ni -- que, nous te bé -- nis -- sons_!
   }
   \new Staff \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure 
          b4. cis?4 8 d4. d cis4. b4 8 cis2.
          b4. cis4 8 d4. d cis4 8 b4 8 cis2.
        } \cadenzaOn\transpose a b \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4. a4 8 g4. g a e4 8 a2.
          e4. a4 8 g4. g a4 8 e4 8 a2.
        } 
      }
   >>
>>