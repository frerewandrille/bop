\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose d c
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 63
          d2 c4 d e c d2\resp d4 c d2 c4 a g2 g\resp a4 g f2 d c d1\fermata
          \bar"|."
        } \tonIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 e4 f g e f2 f4 e d2 d4 e d2 e e4 e d2 d c s1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ils t’ont a -- ban -- don -- né, toi la sour -- ce d’eau vi -- ve, 
     pour des puits des -- sé -- chés.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 bes4 a g bes a2 a4 a f2 g4 a bes2 c c4 bes a2 bes a a1
        } \tonIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d4 d d d d2\resp d4 a bes2 bes4 c d2 c\resp c4 c d2 g a d,1\fermata
        } 
      }
   >>
>>