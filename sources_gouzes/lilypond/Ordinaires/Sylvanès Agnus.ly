\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 2/2 \cadenzaOn \tempo "Très calme et tendre" 
          bes4 a bes c2 \breathe c4 d ees ees ees ees d c c2 bes\fermata\breathe\allowBreak
          a4 bes c2 bes4 a2\fermata \bar ":|." d2 bes4 c2 c bes1\fermata \bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          f4 f f g2 g4 g c c c c g g a2 f f4 f g2 g4 f2 bes f4 g2 f f1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      A -- gneau de Dieu qui en -- lè -- ves les pé -- chés du mon -- de, 
      \set stanza = "1 & 2. " prends pi -- tié de nous.
      \set stanza = "3. " don -- ne_- nous la paix.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 2/2 \cadenzaOn
          d4 c d ees2 ees4 f g g g g f ees ees2 d c4 d ees2 d4 c2 f d4 ees2 ees d1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          bes4 f' d c2 \breathe c4 c c c c c c c <f, f'>2  bes\fermata\breathe
          f'4 d c2 c4 <f, f'>2\fermata bes d4 c2 <f, f'> bes1\fermata
        }
      }
   >>
>>
\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}