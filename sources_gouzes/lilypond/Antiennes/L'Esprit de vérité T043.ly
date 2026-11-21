\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose b a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2 = 50
          b4 b-> b g-> a b2 b4 b d2 b4 a b2 b\fermata\resp
          b4-> b b2 g4 a a2\fermata\resp
          a4-> a b2 b4 b g2\fermata\allowBreak
          g4-> g a-> a a-> b b2\fermata
          \bar"|."
        } \transpose a b \tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g e fis g2 g4 g fis2 g4 fis g2 g
          g4 g d2 e4 d d2 d4 d dis2 dis4 dis e2
          b4 b d d d dis dis!2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      L’Es -- prit de vé -- ri -- té 
      me ren -- dra té -- moi -- gna -- ge_:
      Vous se -- rez mes té -- moins, car vous êtes a -- vec moi 
      de -- puis le com -- men -- ce -- ment.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4-\markup\italic"b.f." (b2) (b) (b) b (a) (a) (b) (b)
          b4 b g2 g4 fis fis2 fis4 fis fis2 fis4 fis e2 
          e4 e fis fis fis fis fis2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4~ e2~ e~ e e (b) (b) (e~) e\fermata\resp
          e4-> e g,2 b4 d d2\fermata\resp
          d4-> d b2 b4 b e2\fermata e4-> e d-> d d-> b b2\fermata
        } \transpose a b \tonIch
      }
   >>
>>