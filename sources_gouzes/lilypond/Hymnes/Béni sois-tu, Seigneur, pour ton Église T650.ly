\version "2.24.0"

\include "vowel-set.ly"

\transpose c bes,
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 3/4 %\cadenzaOn 
          \tempo "Léger" 2. = 72
          c4 c b c2 d4 e2. d4 c b c2. g e'4 e d c2. g2 \breathe \allowBreak 
          g4 a2 (c4) c (b2) \noBreak c2.\fermata \bar"|."
          \mark "Fin"
          \time 2/2 \tempo 2 = 50 \partial2 \oneVoice r4 \voiceOne c c c c b a2. g4 g2. fis4 g2.\breathe
          \omit Score.TimeSignature
          g4 \time 2/4 g4. a8 b4\breathe c a4. a8 \noBreak b1*1/2\fermata \bar":|."
          \mark "D.C."%\break
        }%\cadenzaOn\tonRCaf\cadenzaOff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { %\cadenzaOn
          g4 g g g2 g4 g2. g4 g g g2. g g4 g g g2. e2 e4 f2 (e4 g2) g4 g2.
          \partial2 s4 e a g a g fis2. e4 e2. d4 d2. d4 d e d g g fis g1*1/2
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } {
     \lyricsto "soprano" {\repeat unfold 16 {\skip4} Al -- lé -- lu -- ia_!
     }
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "alto" {
     Bé -- ni sois_- tu, Sei -- gneur pour ton É -- gli -- se
     vi -- vante et sain -- te. Al -- lé -- lu -- ia_!
     Fon -- dée sur les a -- pô -- tres de l’A -- gneau, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes"%\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4 %\cadenzaOn
          e4 e d e2 b4 c2. b4 c d e2. c e4 e d e2. c2 c4 c2. (d2) d4 e2.
          \partial2 \oneVoice r4 \voiceOne c d e d d d2. b4 c2 (b4) a b2. b4 c c d e d4. d8 d1*1/2
        }%\cadenzaOn\tonRCah\cadenzaOff
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { %\cadenzaOn
          c4 e g c2 g4 c2. g4 e g c2. c, c'4 c b c2. c,2 \breathe
          c4 (f g a) g2 g4 c,2.\fermata
          \partial2 s4 a' f e f g d2. e4 c2. d4 g2.\breathe
          g4 c,8 (d) e (fis) g4\breathe c, d4. d8 g,1*1/2\fermata
        }
      }
   >>
   \new Lyrics {
     \lyricsto "basse" {\repeat unfold 16 {\skip4} Al -- lé -- lu -- ia_!
     }
   }
>>