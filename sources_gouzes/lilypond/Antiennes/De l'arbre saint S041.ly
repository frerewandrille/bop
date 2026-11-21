\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  %\with { instrumentName = #"4" }
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key c \major \cadenzaOn \tempo "Sans presser" 2 = 96
          e1 a2 c b (a) g a b1 \breathe \allowBreak e, a2 g a b c1 \bar"|"
          a c2 e d c b (a) g1 \breathe \allowBreak e a2 c b b a1 \bar"|." }
          \relative c'' { a \breve g8[ a] b4 \bar "|" \noBreak a \breve b8[ g] e 4 \bar "||" \noBreak a \breve  g4-+ \bar "|." } 
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { c1 e2 g g (e) e e g1 e e2 e e g g1 f g2 g g e g (f) e1 c d2 e g g e1 } 
        \relative c'' { e, \breve s4 e4 \bar "|" \noBreak e \breve s4 e4 \bar "||" \noBreak e \breve  e 4 } 
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      De1 l’ar2 -- bre saint1 de2 Jes -- sé,1 un ra2 -- meau a fleu -- ri_:1 
      Sur toi,2 Vier -- ge Ma -- ri1 -- e,1 a re2 -- po -- sé l’Es -- prit.1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"  \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c' 
        { \clef "bass" \key c \major \cadenzaOn
          a1 c2 e d (c) b c d1 c c2 b c d e1 c c2 c b a e' (c) c1 g a2 a e'2. 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(-0.5 . 2)\markup { "" } >4
          c1 }
        \relative c' { 	c \breve b8[ c] d4 \bar "|" \noBreak c \breve d8[ b] c4 \bar "||" \noBreak c \breve b4 }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        { a,1 a'2 e g (a) e a g1 \breathe 
          c a2 e a g c,1 f e2 c g' a e (f) c1\breathe
          c f2 a e g a1 }
        \relative c' { 	a \breve s4 g4 \bar "|" \noBreak a \breve g8[ g] a4 \bar "||" \noBreak a \breve e4 }
      }
   >>
>>