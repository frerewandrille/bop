\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         f2. g g f\fermata\resp bes2 4 c2. 2 bes4 a2. a\fermata\bar"|"
         bes2-- 8-- [8--] a2-- bes4-- c2-- 4--\resp bes-- a-- bes-- c2.\fermata\bar"|"
         d2 8 [8] c4-> d ees d (c2->) bes2.\fermata
         \bar"|."
       } \tonVIIIif %pas de ton dans l'orig.
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2. d bes2 (c4) d2. f2 4 fis2. 2 g4 fis!2. 2.
         g2 g8 [g] fis!2 g4 a2 4 g fis! g a2.
         bes2 8 [8] a4 bes4 4 2 (a4) f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ton Corps, ton Sang, nous ap -- por -- te la Vi -- e.
     Nous pro -- cla -- mons ta Pâ -- que, Res -- sus -- ci -- té_!
     Nous cé -- lé -- brons ta vic -- toi -- re_!
   }
   \new Staff \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2. 2. g bes d2 4 2. 2 4 2. 2. 2 8 [8] 2 4 f2 4 d d d f2.
          2 8 [f] 4 4 g f2 (ees4) d2.
        } \tonVIIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes2. g ees' bes\fermata\resp bes'2 4 a2. 2 g4 d2. d\fermata
          g2-- 8-- [g--] d2-- g4-- f2-- 4--\resp g-- d -- g-- f2.\fermata
          bes2 8 [8] f4-> bes ees, f2. <bes, bes'>2.\fermata
        } 
      }
   >>
>>