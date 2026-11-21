\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 1. = 44
         e2 e-> fis g a1\resp a2 g1 a2 b1 b2 c-> (b) a b1.\fermata\bar"|"
         g2-> g g fis1 g2 a-> (g) fis g1.\resp
         g2-> g g a1 a2 g1. g2 fis e fis1.\fermata
         \bar"|."
       } \tonVIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         cis2 cis d d4 (e) fis1 fis2 d1 d2 g1 g2 g (fis) e4 (fis) g1.
         d2 d d d1 d2 d1 d2 d1. d2 d d d1 d2 d1. d2 d cis! d1.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ve -- nez, a -- do -- rons le Christ, le Fils du Dieu vi -- vant,
     que les a -- pô -- tres Pierre et Paul ont an -- non -- cé
     à tou -- tes les na -- tions.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a a b c1 c2 b1 c2 d1 d2 e (d) c d1.
          b2 b b a1 b2 c (b) a b1. b2 b b c1 c2 b1. b2 a a a1.
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a2 a-> d d d1\resp d2 g1 g2 g1 g2 c,-> (d) d g1.\fermata
          g2-> g g d1 d2 d1-> d2 g1.\resp
          g2-> g g fis1 fis2 g1. g2 a a d,1.\fermata
        } 
      }
   >>
>>