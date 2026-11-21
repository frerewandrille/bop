\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = 1.5
  }
}

\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "Vif et léger"
          \revert Staff.TimeSignature.style
          \partial4 d4 c b8 a g4 d g a b c d2 b4 \resp
          d4 c b8 a g4 d g a b c d2
          \bar "|."\mark"Fin"
          \oneVoice r4 \voiceOne d^\markup\italic"calme subito" a d c (b8 d c4)
          b a \resp e a g a b8 c b4 d c b \noBreak a2. \bar":|."%\mark"D.C."          
        }\cadenzaOn \tonVIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 d4 e fis8 fis g4 d b8 (d) fis4 g e d (e) fis
          fis e fis8 fis d4 d e fis g g fis2
          s4 d f d e (f e) d e d e d e e8 e f4 e e d8 (e) fis2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #UP }
   \lyricsto soprano 
   { 
     Un Dieu nous est né au -- jour --\apostrophe d’hui dans la crè -- che.
     Un Dieu nous est né, 
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     \repeat unfold 17 \skip4
     un Fils nous est don -- né.
     Et on l’ap -- pel -- le -- ra_:_
     Dieu fort et Prin -- ce des siè -- cles à ve -- nir.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          \partial4 r4 r d b b8 a g4 d g a b c d2 d r4 d d d d c a2
          r2 R1 r2 r4 d a b c d8 e d4 b a a8 (g) d'2.
        }\cadenzaOn \tonVIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 r4 R1 R1 r2 r4 d g a8 a b4 \resp c b a g e d2
          r2 r r4 d a d c (b8 d c4) b a 
          \once \override BreathingSign.Y-offset = #-1
          \breathe a a gis8 gis a [a] b c d2.
        }
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" } \lyricsto ténor
   {
     Un Dieu nous est né au -- jour --\apostrophe d’hui dans la crè -- che,  
   }
   \new Lyrics \lyricsto basse 
   { 
     Un Dieu nous est né, \repeat unfold 6 { \skip4 }
     Et on l’ap -- pel -- le -- ra le Prin -- ce des siè -- cles à ve -- nir.
   }
>>
