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
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 4 = 84
          f8-- [f16-- e--] d8-- [d--] a'-- [a16-- g--] a2\fermata\resp
          c\breve*1/16 \allowBreak c8 c([b]) c [d] c4 (b8 [a] c [a]) a2\fermata
          \bar"|."
        } \tonVbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c8 [c16 c] d8 [d] f [f16 e] f2
          a\breve*1/16 a8 a ([g]) a [b] a4 (g8 [f] a [f]) f2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Que tous les peu -- ples bat -- tent des mains_:_
      "Le Christ est Roi" par tou -- te la ter -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 [a16 a] a8 [a] c [c16 b] c2 
          f\breve*1/16 f8 f ([d]) f [f] f4 (d8 [c] f [c]) c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8-- [f16-- f--] f8-- [f--] a-- [a16-- g--] f2\fermata\resp
          f\breve*1/16 f8 f ([g]) f [d] f4 (g8 [a] f4) f2\fermata
        } \tonVbh
      }
   >>
>>