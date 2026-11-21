\version "2.24.0"

%\include "vowel-set.ly"
\include "TonsDef.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Méditatif" 2 = 42
          a2 bes2. bes4 bes bes bes bes a2 f2.\fermata\resp
          f4 f-> f f2 \allowBreak a4-> f g2 g2.\fermata\resp
          g4 g g g2. \allowBreak g4^\markup\italic"élargir" a2\fermata a\fermata a\fermata
          \bar"|."
        } \tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 e2. e4 e e e e f2 d2. d4 d d d2 f4 d e2 e2. 
          e4  e e e2. e4 e2 e e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sans moi, vous ne pou -- vez rien fai -- re. 
      Si vous gar -- dez ma pa -- ro -- le, 
      vous ne ver -- rez ja -- mais la mort.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d2. d4 d d d d d2 a2. a4 a a a2 d4 d d2 d2. 
          d4 d c d2. d4 cis2 cis cis
        } \tonIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 g2. g4 g g g g a2 d,2.\fermata\resp
          d4 d-> d d2 d4-> a' bes2 bes2.\fermata\resp
          a4 a c bes2. bes4 a2\fermata a\fermata a\fermata
        } 
      }
   >>
>>