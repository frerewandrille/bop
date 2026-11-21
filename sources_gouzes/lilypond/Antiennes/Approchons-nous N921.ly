\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }

%\transpose f d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          e8 [g] a ([c]) c4 (b8 [c] b4 a) \bar"|"
          \silC g8 a [c] c [c] c4\resp
          c8 [b c] b4 a4.\resp
          a8 g [a] b [g] e4
          \bar"|."
        } \tonIIIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e8 [e] d4 e (g4. e8 f4)
          s8 e d [d] e [e] f4 e8 [g g] g ([e]) f4.
          d8 e [c16 (d)] e8 [e] e4
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
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
           c8 [b] a4 g8 ([a] d [c] d [b] c4)
           \silC b8 a [a] g [g] a4 g8 [d' c] d ([b]) c4.
           a8 b [a] g [b] c4
        }  \tonIIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a8 [e] f4 e8 ([f] g [e] g4 f)
          s8 g f [f] e [e] d4\resp
          e8 [g16 (f) e8] g4 f4.\resp
          f8 e [f] g [e] <a, a'>4
        } 
      }
   >>
>>