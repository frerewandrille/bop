\version "2.24.0"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 4 = 200
          g4 g g-> (e f) g-> f g \bar"|"\time 2/2 a2-> (g4-> f) g2->\resp
          a4-> a a2-> (g4-> f) g1
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e (c d) e d e f2 (e4 d) e2 f4 f f2 (e4 d) e1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c2. c4 c c c1 c2 c4 c c1 c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c4 c c2. c4-> f e d1 c2->\resp f4-> f f2-> (c4-> d) c1
        } 
      }
   >>
>>