 \version "2.24.0"
% %\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }


\transpose g e
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 88
         g8 [g] g [d f] g4. (f8 g [bes] g [f]) g4.\resp
         bes8 bes [c] g [f] g [bes] a ([f]) g4.\resp
         bes8 d [c] g ([f] g) [bes] a [f] g2\fermata
         \bar"|."
       } \tonIIbf % Ton à quatre stiques dans l’original
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     En ta gran -- de ten -- dres -- se, 
     tu t’es of -- fert en sa -- cri -- fi -- ce pour nous la -- ver de nos pé -- chés.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          r4 d4.~ d4 c d ees d g~ g d4 ees f d4. r8 d4 ees d c d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [g] g [bes a] g4. (a8 g [d] g [a]) g4.\resp
          g8 g [f] g [a] g [d] f ([a]) g4.\resp
          g8 d [f] g ([a] g) [d] f [a] g2\fermata
        } \tonIIbh
      }
   >>
>>