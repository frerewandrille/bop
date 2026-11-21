\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose f ees
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo 4 = 88
          f8 c' [c] c [a] c [d] c4 (b8 [a] c [a]) a4.\fermata\resp
          a8 a4. a8 g [a] f4 a8 [b] b4 (a g) a2\fermata
          \bar"|."
        } \tonVff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f8 f [f] f [f] e [e] f4 (g8 [f] e4) f4.
          f8 e4. e8 d [e] d4 f8 [f] e4 (f e) f2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Dans la lu -- miè -- re de ta Pâ -- que,
      ô Christ, nous a -- vons vu la lu -- miè -- re_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f8 a [a] a [c] c [b] a4 (b8 c4.) d 
          d8 c4. c8 b [c] c4 e8 [d] d2 (b4) c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 f [f] f [f] a [g] f2 (a4) f4.\fermata\resp
          f8 f4. f8 g [f] a4 a8 [a] g4 (a b8 [g]) f2\fermata
        } \tonVfh
      }
   >>
>>