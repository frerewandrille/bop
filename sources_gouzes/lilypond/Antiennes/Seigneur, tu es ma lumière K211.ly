\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\transpose d c
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo  2. = 50
          e2. d \oneVoice r2 \voiceOne d4 e-> e d c2. a\fermata \breathe\allowBreak
          a2 c4 a2.\fermata \breathe\allowBreak
          \oneVoice r2 \voiceOne a4 a2. a4-> a a a2. \allowBreak
          a4-> a g a2.\fermata a\fermata \bar "|."
        }\tonVIIef
        %\transpose g a \tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          e2. fis s2 fis4 a a fis a2 (g8 [fis]) e2. e2 fis4 e2.
          s2 e4 e2. e4 e e e2. e4 e e fis2. fis
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   { %\set associatedVoice = #""
     Sei -- gneur, tu es ma lu -- miè -- re, mon sa -- lut_: 
     Je cher -- che la splen -- deur de ton vi -- sa -- ge_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          c2. d \oneVoice r2 \voiceOne d4 c c d e2. c c2 a4 c2.
          \oneVoice r2 \voiceOne c4 c2. c4 c c c2. c4 c c d2. d
        }\tonVIIeh
        %\transpose g a \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          a2. a s2 a4 a-> a a a2. a\fermata \breathe d,2 d4 d2.\fermata
          s2 d4 fis2. fis4-> fis g a2. g4-> fis e d2.\fermata d\fermata
        }
      }
   >>
>>