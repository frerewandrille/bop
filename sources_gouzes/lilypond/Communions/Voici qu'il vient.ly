\version "2.24.0"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         \partial8 f4 f8 e f4 a a g f2\resp
         a4 a8 g a4 a b c8 b a2\resp
         c4 c8 c d4 c8 b a4 g a2
         \bar"|."
         c\breve b4 \bar"'"\noBreak b\breve a4 \bar"|"\noBreak 
         a\breve f8 g4 \bar"'"\noBreak g\breve a f4\bar"||"
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d8 d d4 d cis cis d2 d4 e8 e f4 f e e8 e f2
         e4 e8 e g4 a8 g f4 e e2
         a\breve g4 g\breve f4 f\breve s8 e4 e\breve e d4
       } 
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci qu’il vient par -- mi les siens.
     Voi -- ci le pain qui don -- ne la vie,
     le Pain vi -- vant des -- cen -- du du ciel.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a8 g a4 a e a a2 f4 a8 a d4 d b b8 b c2
          c4 c8 c b4 f8 g a4 b c2
          e\breve d4 e\breve c4 c\breve s8 c4 c\breve cis a4
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d8 d d4 cis a a d2\resp
          d4 cis!8 cis d4 a' g g8 g f2\resp
          a4 a8 a g4 d8 e f4 e a,2
          a\breve e'4 e\breve f4 f\breve s8 c4 c\breve a d4
        } 
      }
   >>
>>