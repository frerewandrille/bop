\version "2.24.0"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Murmuré, vif" 2. = 88
          e4->^\ppp e e e-> d e g2 (e4) e2.\fermata\resp
          a4->^\f a a a-> g a b2 (a4) a2.\fermata\resp
          e4->^\p e e e-> d e f2 (e4) e2.\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e e d e e2. e e4 e e e e e g2 (e4) e2. 
          e4 e e e d e d2 (b4) cis2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, 
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c!4 c c c b c b2. c c4 c c c d c d2 (cis4) cis2. 
          cis!4 cis cis cis b cis a2 (gis4) a2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4-> a a a-> a a e2 (g4) a2.\fermata\resp
          a4-> a a a-> b a g2 (a4) a2.\fermata\resp
          a4-> a a a-> a a d,2 (e4) a2.\fermata
        } 
      }
   >>
>>