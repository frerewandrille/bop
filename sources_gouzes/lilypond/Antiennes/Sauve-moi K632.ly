\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Dynamics { 
  g2 (a4) bes a2. a4 bes2 a4 (g) a2\breathe\allowBreak
  a2^\< a4 a c^\> c bes1 \allowBreak 
  bes4^\<  bes a2. a4 bes2^\> a4 (g) a1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn \tempo  2 = 60
          g2 (a4) bes a2. a4 bes2 a4 (g) a2\fermata\breathe\allowBreak
          a2 a4 a c c bes1 \allowBreak 
          bes4  bes a2. a4 bes2 a4 (g) a1\fermata
          \bar"|."
        }\transpose g bes \tonIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 (a4) bes a2. a4 bes2 a4 (g) a2
          a2 a4 a a a a2 (g) g4 g fis2. fis4 e2 e fis!1           
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sau -- ve_- moi par ton a -- mour_: 
     Ils veu -- lent m’ar -- ra -- cher à la ter -- re des vi -- vants.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          bes2 (c4) d ees2. ees4 d2 c4 (bes) d2 d2 d4 d d d d1 
          d4 d d2. d 4cis2 cis d1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2. g4 fis2. fis4 g2 g fis!\fermata fis2 fis4 fis fis fis g1
          g4 g a2. a4 g2 g d1\fermata
        }\transpose g bes \tonIIdh
      }
   >>
>>