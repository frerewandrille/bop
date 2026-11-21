\version "2.24.0"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Calme" 4 = 69
          f8 [f] f [f] e [f] g4 (d) f2\fermata\resp
          a8 [a] a[a] g [a] bes ([a] g4^\markup\italic"rall.") a2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c8 [c] c [c] c [c] d4 (bes) c2
          f8 [f] f [f] f [f] f4 (d8 [e]) f2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 [a] a [a] g [a] bes ([a] g4) a2
          c8 [c] c [c] bes [c] d ([c] bes4) c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 [f] f [f] f [f] bes,2 <f f'>\fermata\resp
          f'8 [f] f [f] f [f] f4 (g) f2\fermata
        } 
      }
   >>
>>