\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"
%gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      {  \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          r8 f [g] g4 (a8 [bes] c [d]) c4. \bar "|"
          c8 a4 bes8 [a] g4.\resp a8 g [f] g [bes] bes4.\bar "|"
          c4 bes8 ([a]) g4 g\fermata
          \bar"|."
        } \tonIIhf
      }
   >>
   \new Lyrics \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia_! 
      Cher -- chez le Sei -- gneur qui rè -- gne dans les cieux, 
      Al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4. c2 d4 d4. d\breve*1/16 s1. d4.
          d4 ees d8 ([c]) d4
        } \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*9/16 g4. g\breve*1/16 s1. g4.
          g\breve*3/8 g4
        } 
      }
   >>
>>