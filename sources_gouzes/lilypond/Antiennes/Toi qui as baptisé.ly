\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Large"% 2 = 52
          bes2 bes4 bes a? a bes bes g2. \allowBreak g4 g2 f g\resp
          ees ees4 ees f f aes2 aes4 \allowBreak
          aes g g f2 ees4 ees f f g2 g\fermata
          \bar"|."
        } \transpose c bes, \tonVff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g4 g f f g g ees2. ees4 ees2 c ees
          bes bes4 bes c c ees2 ees4 
          ees ees ees c2 bes4 bes c c ees2 ees
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Toi qui as bap -- ti -- sé le Christ, bé -- ni sois_- tu_!
      Tu as tou -- ché la flam -- me
      dont la splen -- deur fait trem -- bler les an -- ges.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          ees2 ees4 ees c c ees ees bes2. bes4 c2 a bes
          g g4 g a a c2 c4 c bes bes a2 g4 g a! a bes2 bes
        } \transpose c bes, \tonVfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees2 ees4 ees f f ees ees ees2. ees4 c2 f ees\resp
          ees ees4 ees ees ees ees2 ees4 ees ees ees f2 
          g4 g f f ees2 ees\fermata
        } 
      }
   >>
>>