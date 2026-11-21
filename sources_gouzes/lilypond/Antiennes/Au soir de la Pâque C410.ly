\version "2.24.0"
% %\include "TonsDef.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme, paisible" 2 = 54
         a4 g2 f4 bes g2 a\fermata \resp 
         c bes4 a bes2 bes a2. \allowBreak a4 g2 f4 bes g g a2 \resp
         bes\fermata g\fermata a\fermata
         \bar"|."
       } \tonVIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4 e2 d4 d e2 f f d4 f f2 e f2. f4 e2 d4 d e e f2 f e f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Au soir de la Pâ -- que, toi, l’A -- gneau im -- mo -- lé,
     tu as é -- ten -- du les mains sur la croix.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c2 a4 bes c2 c a bes4 c d2 c c2. c4 c2 a4 bes c c c2 d c c
        } \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 c2 d4 g c,2 f\fermata\resp
          f g4 f bes,2 c f2. f4 c2 d4 g c, c f2\resp
          bes,\fermata c\fermata f\fermata
        } 
      }
   >>
>>