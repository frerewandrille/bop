\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/2 \cadenzaOn \tempo 2. = 44
          a2. f2 g4 a2. bes2 (a4) g2.\fermata a2 bes4 c2. bes2 a4 g2. (a) f\fermata\bar "|."
          \bar "|."
        } \tonVIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          f2. c2 c4 f2. f2 (fis4) d2. \breathe f!2 f4 f2. f2 d4 d2. (e) c
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
     C’est dans ta Croix, ô Christ, que je trou -- ve ma gloi -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major\cadenzaOn
          c2. a2 bes4 c2. d2 (c4) bes2. \breathe c2 d4 ees2. d2 c4 bes2. (c) a
        } \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f2. f2 f4 f2. d g\fermata f2 f4 f2. f2 fis4 g2. (c,) f\fermata
        }
      }
   >>
>>