\version "2.24.0"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 72
          f4-> f e f-> f g a2. g\resp 
          g4-> g a f-> e f g2 (f4) e2.\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d cis d d e f2. e e4 e e d cis! d e2 (d4) cis!2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a a a a c c2. c c4 c a a a a c2 (a4) a2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4-> d a d-> d c f2. c\resp 
          c4-> c cis d-> a d c!2 (d4) a2.\fermata
        } 
      }
   >>
>>