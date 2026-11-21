\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose c g,
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 72
         \tuplet 3/2 { c4 a c } c (d c2 b4 a c2 a\fermata)\bar"|"
         \tuplet 3/2 { a4 g a } c2 \tuplet 3/2 { b4 c b } a2 a4 a a2 (g) a2. \allowBreak
         a4 f2 g a1\fermata
         \bar"|."
       } \tonVbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         a4*2/3 f a a4 (b a2 g4 f a2 f) 
         f4*2/3 e f f2 g4*2/3 g g f2 f4 f f2 (e) f2. f4 d2 d4 (e) f1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Jé -- ru -- sa -- lem_! Lè -- ve les yeux à l’O -- ri -- ent et re -- gar -- de, 
     Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4*2/3 c c c1~ c2~ c1 c4*2/3 b c c2 d4*2/3 e d c2 c4 c c2 (d) c2. c4 c2 b c1
        } \tonVbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \tuplet 3/2 { f4 f f } f1~ f2~ f1\fermata
          \tuplet 3/2 { f4 g f } a2 \tuplet 3/2 { g4 g g } a2 a4 a a2 (b) a2. a4 a2 g f1\fermata
        } 
      }
   >>
>>