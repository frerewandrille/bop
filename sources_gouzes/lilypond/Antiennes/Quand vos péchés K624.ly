\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 3/4 \cadenzaOn %\tempo "" 2 = 52
          a\breve*1/16 c2 c4 b a a2 (gis4 fis) gis!2\breathe\allowBreak
          gis!\breve*1/16 a2 a4 a a a2 (gis!) a2\fermata
          \bar"|."
        }\tonIVef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c\breve*1/16 e2 e4 f e e1 e2 e\breve*1/16 c2 c4 c c d1 e2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      "Quand vos péchés seraient comme la" pourpre et l’é -- car -- la -- te, 
      "ils deviendront" blancs com  -- me la nei -- ge_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4 \cadenzaOn
          a\breve*1/16 a2 a4 a a b1 b2 b\breve*1/16 a2 a4 a a b1 c2
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a\breve*1/16 a2 a4 d f e1 e2\breathe 
          e\breve*1/16 f2 f4 f f e1 a,2\fermata
        }\tonIVeh
      }
   >>
>>