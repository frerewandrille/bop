\version "2.24.0"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 72
          g4-> g f g-> g a bes2 (g4) g2.\fermata\resp 
          c4-> c d c-> bes a bes2 (g4) g2.\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e d e e f f2 (d4) e2. e4 e f e d f f2 (d4) e2.
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
          c4 c c c c c d2 (bes4) c2. 
          g4 g bes g bes c d2 (bes4) c2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c4-> c c c-> c f bes,2 (g'4) c,2.\fermata\resp 
          c4-> c bes c-> g' f d2 (g4) c,2.\fermata
        } 
      }
   >>
>>