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
        { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 60
          a2 a4 a g2 g4 g f2 f e2.\fermata\resp 
          e4 e^> e d2. d4 d^> c e2\fermata e\fermata
          \bar"|."
        } \tonIVbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e4 e e2 e4 e c2 c g2. c4 c c b2. b4 b a gis2 gis
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Par ses souf -- fran -- ces, mon ser -- vi -- teur 
     ra -- chè -- te -- ra les mul -- ti -- tu -- des.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 c b2 b4 b a2 a4 (b) c2. g4 g g g2. g4 g c b2 b
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 a e2 e4 e f2 f c2.\fermata\resp 
          c4 c_> c g2. g4 g_> a e'2\fermata e\fermata
        } \tonIVbh
      }
   >>
>>