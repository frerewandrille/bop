\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  %\with { instrumentName = #"6" }
<< \new Staff 
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo  "Souple et léger" 2. = 44
          c4^> a c d2^> c4 c2. \allowBreak\breathe 
          c4^> a c d2^> c4 c2. \allowBreak\breathe 
          c4^>^\markup{\italic rall.} c a d2^> d4 c2-> c4 a2.\fermata \bar "|." }
          \relative c'' { a \breve bes8[ g] a4 \bar "|" \noBreak a \breve g8[ f] g4 \bar "||" \noBreak a \breve  g4-+ \bar "|." }
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'  
        {
          f4 f f f2 e4 f2. f4 f f f2 e4 f2. f4 f f f2 f4 e2 e4 c2. }
          \relative c'' { f, \breve f8[ e] f4 \bar "|" f \breve d8[ d] e4 \bar "||" f \breve  e 4 }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      É4 -- gli -- se du2 Sei4 -- gneur,2. é4 -- pou -- se bien2 ai4 -- mée,2. 
      le4 Roi dé -- si2 -- re4 ta2 beau4 -- té.2.
   }
   \new Staff
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          a4 c a bes2 g4 a2. a4 c a bes2 g4 a2. a4 a c bes2 bes4 g2 g4 f2. }
          \relative c' { 	c \breve d8[ c] c4 \bar "|" c \breve bes8[ a] c4 \bar "||" c \breve c4 }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          f,4-> f f bes,2-> c4 f2. \breathe f4-> f f bes,2-> c4 f2. \breathe f4-> f f bes,2-> bes4 c2-> c4 f2. \fermata}
          \relative c' { 	f, \breve bes,8[ c] f4 \bar "|" f \breve f8[ f] c4 \bar "||" f \breve c4 }
      }
   >>
>>