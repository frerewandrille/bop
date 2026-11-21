\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose bes a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Calme et mystérieux" 2 = 69
          bes4 bes2 bes4 bes a? a bes bes g2 ees2.\resp
          ees4 ees2 f g\fermata
          \bar"|."
        } \transpose c bes, \tonVff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g2 g4 g f f f f ees2 bes2. bes4 c2 c4 (d) ees2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      In -- cli  -- ne mon cœur vers ta pa -- ro  -- le, 
      Sei -- gneur mon Dieu.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          ees4 ees2 ees4 ees c c d d bes2 g2. g4 g2 a bes
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees4 ees2 ees4 ees f f d d ees2 ees2.\resp ees4 c2 f ees\fermata
        } \transpose c bes, \tonVfh
      }
   >>
>>