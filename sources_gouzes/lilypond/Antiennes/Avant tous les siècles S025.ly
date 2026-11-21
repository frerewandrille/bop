\version "2.24.0"
%\include "TonsDef.ly"

\transpose b a
\new ChoirStaff  %\with { instrumentName = #"1" }
<< \new Staff 
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn 
          b4 b a b g (a) b2 \breathe \allowBreak b4 d d2 c4 b a2. \bar "|" b4 a^> b g a b2 \breathe \allowBreak a4 b c8 [b] a [g] a2 g \bar "|." }
        \cadenzaOn \relative c'' { b \breve c8[ a] b4 \bar "|" \noBreak b \breve a8[ g] a 4 \bar "||"\noBreak  b \breve  a4-+ \bar "|." }
        %\tonVIlf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c''  
        { \cadenzaOn 
          g4 g fis d e (fis) g2 g4 g g2 g4 g fis2. g4 fis d e fis g2 fis4 g g8 [g] e [e] fis2 g }
        \cadenzaOn \relative c'' { g \breve g8[ fis] g4 \bar "|" g \breve e8[ e] fis4 \bar "||" g \breve  fis 4 }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     A4 -- vant tous les siè2 -- cles, le4 Sei -- gneur2 t’a4 ai -- mée,2. 
     et4 tu as fait sa joie2 par4 -- mi les8 en -- fants des hom2 -- mes_!
   }
   \new Staff
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn 
          d4 d d b b (d) d2 d4 b b2 e4 d d2. d4 d b b d d2 d4 d e8 [e] b [b] d2 b }
        \cadenzaOn \relative c' { d \breve e8[ d] d4 \bar "|" d \breve c8[ b] d4 \bar "||" d \breve d4 }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          g4 g d g e (d) g2 \breathe g4 g g2 c,4 g' d2. 
          g4 d-> g e d g2 \breathe d4 g c,8 [c] e [e] d2 g, }
        \cadenzaOn \relative c' { g \breve c,8[ d] g4 \bar "|" g \breve s4 d4 \bar "||" g \breve d4 } 
        %\tonVIlh
      }
   >>
>>