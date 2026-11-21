\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes"\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo 4 = 76
          d8 [d] \tuplet 3/2 { a' [g a] } \tuplet 3/2 { c ([b a] }
          c [a]) a2\fermata\resp
          a\breve*1/8 g8 [a] f [g] g4.\resp
          a8^\markup\italic"ralentir" f [f] d2\fermata
          \bar"|."
        } \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d8 [d] f8*2/3 [e f] a ([g f] a8 [f]) f2
          f\breve*1/8 f8 [f] d [e] e4. e8 d [d] d2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Au ma -- tin de ta Pâ -- que, "tu nous as" ras -- sa -- siés,
      Sei -- gneur, de ton amour_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d4--^\markup\italic"b.f." f-- a-- c-- d2 c\breve*1/8  d8 [d] d [d] c4.
          c8 a [bes] a2
        } \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d1 d2\fermata\resp f\breve*1/8 bes8 [bes] 
          bes [bes] c4. \resp c,8 d [g,] d'2\fermata
        } 
      }
   >>
>>