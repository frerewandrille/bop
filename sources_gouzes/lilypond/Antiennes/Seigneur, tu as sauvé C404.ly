\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn 
         \tempo "Extatique, calme et balancé" 2 = 52
         g4 d'-> d c-> d e-> c d bes bes c d2.\fermata\bar"|"
         g,2 bes4-> bes a-> bes g-> g \allowBreak 
         g-> a bes-> g g-> a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g\breve s2. g e2 g4 g e! e d d e! e g d e! e d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur, tu as sau -- vé mon â -- me de la mort_:
     Je marche en ta pré -- sen -- ce sur la ter -- re des vi -- vants.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 bes_> bes a_> bes c_> a bes g g a bes2.
          c2 d4 d c c bes bes c c d bes c c d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve s2. g\fermata
          c,2 g'4-> g c,-> c g'-> g c,-> c g'-> g c,-> c g'2\fermata
        } \tonIIbh
      }
   >>
>>