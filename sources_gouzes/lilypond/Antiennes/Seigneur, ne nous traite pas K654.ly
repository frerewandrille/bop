\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 60
          g2 d'1\fermata\resp d4 d d c c2. \allowBreak
          c4 c2 c4 bes bes2.\resp
          bes4 bes bes bes2 \allowBreak bes4 bes2 a4 g a2\fermata a\fermata
          \bar"|."
        } \tonIIaf %ton à quatre stiques dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 ees1 ees4 ees ees ees f2. f4 f2 f4 f d2.
          d4 d d e2 e4 e2 e4 e d2 d
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, ne nous trai -- te pas se -- lon nos pé -- chés, 
      ne nous rends pas se -- lon nos of -- fen -- ses_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 g1 g4 g g g a2. a4 a2 a4 a g2. g4 g g g2 g4 g2 g4 g fis2 fis
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 ees1\fermata\resp ees4 ees ees ees d2. d4 d2 d4 d g,2.\resp 
          g4 g g c2 c4 cis2 cis4 cis d2\fermata d\fermata
        } 
      }
   >>
>>