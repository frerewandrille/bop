\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif et détaché" 4 = 120
          g4 g8 [g] a4 a8 [a] c4 c a-> a2\resp a4 bes-> 
          bes8 [bes] a4 a g2*1/2^\< s4^\> g2\fermata\!
          \bar"|."
        } \tonIIjf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d8 [d] f4 f8 [f] g4 g f f2 f4 f f8 [f] f4 f d2 d
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      É -- le -- vez_- vous, por -- tes é -- ter -- nel -- les_: 
      Qu’il en -- tre, le Roi de gloi -- re_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b8 [b] c4 c8 [c] ees4 ees c c2 c4 d d8 [d] c4 c b!2 b
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g8 [g] f4 f8 [f] c4 c f-> f2\resp
          f4 bes,-> bes8 [bes] f'4 f g2 g\fermata
        } \tonIIjh
      }
   >>
>>