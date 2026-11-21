\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }


\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 3/4 \cadenzaOn %\tempo "" 2 = 52
          c\breve*1/8 b4 c d2 c4 b c (b) a2\breathe\allowBreak
          a\breve*1/8 a2 a4 g a2 a\fermata\bar"|."
        }\tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e\breve*1/8 d4 e f2 e4 e e2 e e\breve*1/8 e2 e4 e e2 e
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      "Si quelqu’un" veut mar -- cher à ma sui -- te, "qu’il prenne sa" croix et me sui -- ve_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4 \cadenzaOn
          a\breve*1/8 a4 a a2 a4 gis a (b) c2 c\breve*1/8 b2 b4 b c2 c
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          a\breve*1/8 a4 a d2 e4 e e2 e\breathe
          e\breve*1/8 e2 e4 e a,2 a\fermata
        }\tonIIIah
      }
   >>
>>