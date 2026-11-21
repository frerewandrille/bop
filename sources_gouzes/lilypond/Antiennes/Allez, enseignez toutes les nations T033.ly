\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 69
          e2 e fis4 g a2 b2. b4 a2 g fis\fermata\resp
          b4-> cis d2. \allowBreak d4 d-> (cis) d \allowBreak b a2. (g4) fis2\fermata\resp %\bar"|"
          fis e e4 e a2 \allowBreak a4 a fis1\resp fis2 fis4 fis e1 g2 fis-> fis1\fermata
          \bar"|."
        } \tonVef% Sans ton dans l’original (invitatoire)
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          cis2 cis d4 e fis2 g2. g4 fis2 e fis 
          g4 a b2. b4 b (a) b g fis2 (e) d
          d cis cis4 cis cis2 cis4 cis d1 d2 d4 d b1 cis2 d d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lez, en -- sei -- gnez tou -- tes les na -- tions.
      Pro -- cla -- mez la Bon -- ne Nou -- vel -- le_:
      Voi -- ci que je suis a -- vec vous 
      jus -- qu’à la fin du mon -- de_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a a4 a d2 d2. d4 d2 b4 (cis) d2
          d4 d d2. d4 d2 d4 d d2 (cis) a
          a a a4 a a2 a4 a a1 a2 a4 a g1 g2 a a1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a a4 a d,2 g2. g4 a2 a d,\fermata\resp
          d4-> d g2. g4 g2-> g4 g a1 d,2\fermata
          d a' a4 g fis2 e4 e d1\resp d2 d4 d e1 e2 d-> d1\fermata
        } \tonVeh
      }
   >>
>>