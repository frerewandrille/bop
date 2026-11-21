\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
silB = { \oneVoice r2 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo \markup{ \dynamic pp "dansant et calme" }
         a2 g4 bes-.-> a-. g-. a2 f4\resp f->^\markup\italic"cresc." a c c2\resp
         a4 bes2-> a8 ([g]) a2\resp c4 d2-> c8([bes]) c2\resp
         a4 bes2-> a8 ([g]) a2.\fermata
         \bar"|."
       } \tonVIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2 4 d d e f2 c4 f f a a2 f4 d2 e4 f2 a4 bes2 a8 ([g]) a2
         f4 <d f>2 e4 f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Christ, ô Pâ -- que nou -- vel -- le, nous te chan -- tons,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 bes4 d c bes c2 a4 \resp a c f f2 c4 d2 c8 ([bes]) c2
          f4 2 4 2 c4 d2 c8 ([bes]) c2.
        } \tonVIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          r2 f4 2 4 2 4 2 4 2 \resp 4 f2 c4 f2\resp f4 bes2 4 f2\resp 
          f4 bes,2 c4 f2.\fermata
        } 
      }
   >>
   \new Lyrics \lyricsto "basse"
   {
     al -- lé -- lu -- ia, al -- lé -- lu -- ia,
   }
 >>