\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          a\breve*1/16 c2 c\breve*1/16 b4 a a2 (gis4 fis) gis!2\resp 
          gis!\breve*1/16 a2 a4 a2 gis! a\fermata
          \bar"|."
        } \tonIVmf
        %\tonIVef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c\breve*1/16 e2 e\breve*1/16 f4 d e1 e2 
          e\breve*1/16  c2 c4 d2 d e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      "Je mettrai ma" loi "au fond" de votre ê -- tre, 
      "et je l’écri" -- rai sur vo -- tre cœur.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a\breve*1/16 a2 a\breve*1/16 a4 a b1 b2 
          b\breve*1/16 a2 a4 b2 b c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a\breve*1/16  a2 a\breve*1/16 d4 f e1 e2\resp 
          e\breve*1/16 f2 f4 e2 e a,\fermata
        } \tonIVmh
        %\tonIVeh
      }
   >>
>>