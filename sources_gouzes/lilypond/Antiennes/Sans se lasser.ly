\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          f4 f8 [g] a2 g4 bes a2 f \breathe\allowBreak f4 f8 [f] e [f] g2 f4 e f2 \breathe\allowBreak
          a4 f8 [g] a4. a8 bes4 bes a2 a4 g8 [f] g4 (a) f2\fermata \bar "|."
        }\tonVIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          c4 c8 [c] f2 f4 e f2 c c4 c8 [c] c [c] d2 c4 c c2
          f4 f8 [f] f4. f8 g4 e f2 f4 d8 [d] e2 c
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      Sans4 se8 las -- ser,2 Do4 -- mi -- ni2 -- que 
      a4 con8 -- tem -- plé ta fa2 -- ce,4 Sei -- gneur,2
      et4 son8 vi -- sage4. a8 ra4 -- yon -- né2 de4 ta8 lu -- miè2 -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
          a4 a8 [bes] c2 bes4 d c2 a a4 a8 [a] g [a] bes2 a4 g a2
          c4 a8 [bes] c4. c8 d4 c c2 c4 bes8 [a] bes4 (c) a2
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          f4 f8 [f] f2 f4 c f2 f \breathe f4 f8 [f] c [c] c2 c4 c f2 \breathe
          f4 f8 [f] f4. f8 bes,4 c f2 f4 c8 [c] c2 f\fermata
        }\tonVIgh
      }
   >>
>>