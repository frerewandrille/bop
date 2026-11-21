\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         e4-> d g a2 c4 c2. c \resp 4-> d c b2 c4 b2 a4 g2. g\resp
         g4-> b a g2 e4 f2 g4 2. 2.\bar"|" 2-> a4 g-> (f) g4 2-> f4 e2. e\fermata         
         \bar"|."
       } \tonIIIff
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 d e fis2 g4 2. 2. 4 fis! g gis2 a4 fis2 4 d2. d
         d4 g fis! e2 c4 2 4 b2. b c2 f!4 d2 4 e2 d4 b2 (c4) b2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu fais jail -- lir les sour -- ces et tu a -- breu -- ves les mon -- ta -- gnes_;
     tu for -- ti -- fies le coeur de l’hom -- me, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 fis b d2 e4 2. e e4 d e e2 4 d2 4 b2. b
          b4 d d b2 c4 a2 g4 2. g g2 c4 b (c) b c2 a4 gis2 (a4) gis2.
        } \tonIIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> fis e d2 c4 2. c\resp c'4-> a c e,2 a4 d,2 4 g2. g\resp
          4-> g d e2 a4 f2 e4 d2. d e2-> f!4 g-> (a) g c,2-> d4 e2. e\fermata
        } 
      }
   >>
>>