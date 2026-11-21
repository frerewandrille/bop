\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn \tempo 2 = 60
          f2 a4 a g a f2. (a4) c2 d a \breathe\allowBreak
          a a4 a e2. (f4 g2 f) g \breathe\allowBreak
          a2. a4 e1\fermata f\fermata d\fermata \bar "|."
        }\tonIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d2 e4 e d c d2 (e) f4 (e) d (e) f2 f f4 f c1 (d) e2 e2. e4 c1 d d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      Le2 Sei4 -- gneur don -- ne -- ra1 son2 bien -- fait,
      et no4 -- tre ter\breve -- re2
      don2. -- ne4 -- ra1 son fruit.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
          a2 c4 c bes c a1 a2 bes c c c4 c 
          %\once \override NoteColumn.force-hshift = #1 
          a1 (bes) c2 c2. c4 a1 bes a
        }\tonIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d2 c4 c d e f2 (e) d4 (c) bes (c) f2 \breathe f f4 f 
          \once \override NoteColumn.force-hshift = #-0.5
          a1 (g) c,2 \breathe
          c2. c4 c1\fermata bes\fermata d\fermata
        }
      }
   >>
>>