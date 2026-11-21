\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"
%gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes\breve*1/16 \unHideNotes }
armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

%\transpose f d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          e8 [g] a ([c]) c4 (b8 [c] b4\fermata a\fermata) \bar"|"
          \silC g8 a [c] c [c] c4\resp
          c8 [b c] b4 a4.\resp
          a8 g [a] b [g] e4
          \bar"|."
        } \tonIIIff
      }
   >>
   \new Lyrics \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia_!
      Ap -- pro -- chons_- nous du Christ,
      Pier -- re vi -- van -- te, 
      pré -- cieuse aux yeux de Dieu_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
           e\breve*1/16 s s s e1
           r8 e8 d [d] c [d] e4 e8 [e d] c ([d]) e4.
           e8 f [e] d [c] b4
        }  \tonIIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
           e\breve*1/16 s s s e1\fermata
           e\breve*1/16 s s s s s e4\resp
           e\breve*1/16 s s s s e4.\resp
           e\breve*1/16 s s s s e4
        } 
      }
   >>
>>