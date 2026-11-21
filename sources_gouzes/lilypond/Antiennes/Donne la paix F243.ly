\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose bes g

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 66
          bes2 ees4 ees d2 c bes\resp bes c4 c bes bes g g a2 g\fermata
          \bar"|."
        } \transpose c bes, \tonVff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g4 g g2 ees4 (f) g2 g ees4 f g g ees ees c (d) ees2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Don -- ne la paix, Sei -- gneur,
      à ceux qui gar -- dent ta Pa -- ro -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 c4 c bes2 c d d c4 c d d c c a2 bes
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees2 c4 c g'2 aes g\resp g aes!4 aes g g c, c f2 ees\fermata
        } \transpose c bes, \tonVfh
      }
   >>
>>