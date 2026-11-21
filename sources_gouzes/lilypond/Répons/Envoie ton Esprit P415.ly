\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Dansant"% 2 = 52
         f4^\ppp f4 f8 [g] a4 bes4.-> (a8 g4 bes) a2.\allowBreak
         a4 g4. f8 e ([f]) g4 f2\resp
         f4 f8 [e] f [g] a2 \allowBreak
         a4 bes4. a8 g4 bes a-> (g8 [f] g4.-> f8) f2\fermata
         \bar"|."
       } \tonVIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c4 c4 c8 [c] f4 f2 (d4 f) f2.
         f4 c4. c8 c4 c c2
         c\breve*3/8 f2 f4 f4. f8 d4 f f (c e4. c8) c2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     En -- voie ton Es -- prit, Sei -- gneur, et tout se -- ra cré -- é.
     Tu re -- nou -- vel -- le -- ras la fa -- ce de la ter -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a4 a8 [bes] c4 d4. (c8 bes4 d) c2.
          c4 bes4. a8 g ([a]) bes4 a2
          a4 a8 [g] a [bes] c2 c4 d4. c8 bes4 d c (bes8 [a] bes4. a8) a2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f4 f8 [f] f4 bes,1-> f'2. f4 c4. c8 c4 c f2 \resp
          f\breve*3/8 f2 
          f4 bes,4. bes8 bes4 bes f'2-> (c4.-> f8) f2\fermata
        } \tonVIgh
      }
   >>
>>