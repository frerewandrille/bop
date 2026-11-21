\version "2.24.0"

armure = { \key c \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Très vif, dansant et carillonant" 2 = 126
          a4---> a-- a---> (g--) a2\resp 
          a4-> b c-> (b a-> g) a1\resp
          c2-> c4-> d c2\resp c4-> b a2-> (g->) a1\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f f (e) f2 f4 g g2 (f4 e) f1 
          f2 f4 e f2 f4 g g (f e2) f1
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
          c4 c c (b) c2 c4 d e (d c b) c1
          c2 c4 b c2 c4 d e ( d c b) c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4---> f-- f---> (g--) f2\resp 
          f4->e d-> (e f-> g) f1\resp
          a2-> a4-> g a2\resp a4-> g f2-> (g->) f1\fermata
        } 
      }
   >>
>>