\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 4/4 }
resp = { \breathe\allowBreak }


\transpose bes g
\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \revert Staff.TimeSignature.style \tempo "Moderato"
         r4 bes4 4 a g2 d' c4 d8 (ees) ees2 d4 bes bes a g2 d' c4 d8 (ees) ees2 d\fermata
         r2 f4 f d d c d bes2 d4 d8 (ees) f2 d d4 (bes) c2 d\fermata
         bes4 a g2 f g4^\markup\italic"rall." a \tuplet 3/2 { bes (g bes) } \tuplet 3/2 { c (d) c } bes2 (a) \noBreak g1\fermata
         \bar"|."
       } \cadenzaOn \tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         r4 d f f d2 f f4 f g (a) bes d, f f ees2 f f4 f g (a) bes2 r
         f4 f f f f f d2 g4 g a2 a g g4 (a) bes2
         f4 f d2 d ees4 ees f2 f2*2/3 f4*2/3 f1 d
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Bé -- ni sois_- tu, Ver -- be du Pè -- re.
     Tu es ve -- nu sur no -- tre ter -- re
     pour sau -- ver l'hu -- ma -- ni -- té.
     Ô Jé -- sus, Em -- ma -- nu -- el_! Gloire à toi, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \revert Staff.TimeSignature.style
          r4 bes c c bes2 a a4 a c2 d4 bes d d bes2 2 a4 a c2 d 
          r c4 c bes bes a a bes2 4 4 c2 d ees2 2 f
          d4 c bes2 a c4 c d2 a2*2/3 a4*2/3 d2 (c) bes1
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          r4 g f f g2 d f4 4 c2 bes4 g' d d ees2 bes f'4 f c2 bes\fermata
          r2 a4 a bes4 4 f' f g2 4 4 f2 2 ees c bes\fermata
          4 f' g2 d c4 c bes2  \tuplet 3/2 { f'2 f4 } d2 (f) g1\fermata
        } 
      }
   >>
>>