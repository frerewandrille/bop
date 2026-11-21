\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Lent" 2 = 72
          a2. gis4 a2 b c1\resp c2 c4 b a1 gis\bar"|"
          gis!2 gis4 gis a2 a a2. a4 gis!1\resp 
          gis!2 a1 b2 c1 (b2 a) a1 gis2 a1\fermata
          \bar"|."
        } \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2. e4 e2 g g1 g2 g4 g e1 e e2 e4 e c2 c c2. d4 e1
          e2 e1 g2 g1. (e2) e1 e2 e1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Bien -- heu -- reuse es_- tu, Vier -- ge Ma -- ri -- e,
      toi qui as por -- té dans ton sein le Fils du Père é -- ter -- nel.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2. b4 c2 d e1 e2 e4 d c1 b b2 b4 b a2 a a2. a4 b1
          b2 c1 d2 e1 (d2 c) b1 b2 cis1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2. e4 a2 g c,1\resp 
          c2 c4 g' a1 e e2 e4 e f2 f f2. f4 e1\resp
          e2 a1 g2 c,1 (g'2 a) e1 e2 a1\fermata
        } \tonIVah
      }
   >>
>>