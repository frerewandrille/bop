\version "2.24.0"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 4 = 112
          gis8 [a] b4. (a8) gis!4\resp a8 [b] c4. (b8) a4\resp
          gis!8 [a] b4 (c8 [b] a4 gis!) a2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e8 [e] e2 e4 e8 [e] e2 e4 e8 [e] g4. (f8 e2) e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 [c] d4. (c8) b4 c8 [d] e4. (d8) c4
          b8 [c] d4 (e8 [d] c4 b) c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 [e] e2 e4\resp a8 [a] a4. (gis8) a4\resp
          e8 [a] g4 (c,8 [d] e2) <a, a'>2\fermata
        } 
      }
   >>
>>