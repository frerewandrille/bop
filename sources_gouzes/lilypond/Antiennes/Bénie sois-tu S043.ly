\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  %\with { instrumentName = #"5" }
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn \tempo "Berceur et calme" 2. = 52
          bes4^> a bes g2 g4 bes^> a bes g2 \breathe \allowBreak g4 a2^> a4 a^> (g) f g2. \bar "|"
          c2 c4 c^> bes a bes2 (a4) g2^> \breathe \allowBreak g4 a2^> a 4 a^> (g) f g2. \bar"|." }
          \transpose a g {\relative c'' { c \breve b8[ c] a4 \bar "|" \noBreak b \breve g \breve a4 \bar "||" \noBreak c \breve  a4-+ \bar "|." } }
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c''
        { bes4 a bes g2 g4 bes a bes g2 g4 ees2 ees4 f2 d4 d2. g2 g4 g g g g2 (d4) d2 d4 ees2 ees4 f2 d4 d2. } 
        \transpose a g {\relative c'' { a \breve s4 f4 \bar "|" \noBreak f \breve e \breve e4 \bar "||" \noBreak a \breve  f4 } }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      Bé4 -- nie sois_- tu,2 ô4 Vier -- ge Ma -- rie,2 ô4 Mè2 -- re4 du2 Sei4 -- gneur,2.
      Mè2 -- re4 du Roi de gloi2. -- re,2 ô4 Mè2 -- re4 du2 Sau4 -- veur_!2.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \minor \cadenzaOn
          d4 c d bes2 bes4 d c d bes2 bes4 c2 c4 a2 a4 bes2. ees2 ees4 ees d c d2 (c4) bes2 bes4 c2 c4 a2 a4 bes2. }
        \transpose a g {\relative c' { 	e \breve s4 d4 \bar "|" \noBreak d \breve b \breve c4 \bar "||" \noBreak e \breve d4 } }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        { g2. g f ees2 \breathe d4 c2-> c4 d2-> d4 g2. 
          c,2 c4 c-> d ees d2. g2-> \breathe g4 c,2-> c4 d2-> d4 g2. }
        \transpose a g {\relative c' { 	a \breve s4 d,4 \bar "|" \noBreak d \breve e \breve <a, a'>4 \bar "||" \noBreak a' \breve a4 } }
      }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"basse"
      Bé2. -- nie sois_- tu,2 
   }
   >>
>> 