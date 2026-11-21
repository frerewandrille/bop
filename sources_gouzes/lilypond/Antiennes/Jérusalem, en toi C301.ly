\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff = "femmes"
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo  "Majestueux, librement, comme un cri"
          e,4^ > g a c2^> (e4 d2^> a4 c2^> b8 [a] b4^> a g a2.)\fermata \bar"|"
          \time 2/2 \tempo  "Très martelé" 4 = 112
          a8^>^\< [ a a g] a8^> [ a a b] c4 \allowBreak b8 [c] a4.\! \allowBreak e'8 d4 c8 ([b]) a4. \breathe \allowBreak
          a8 c^> [c b c] d4 \allowBreak c8 [b] a4. \allowBreak a8 c4 b8 ([c]) a2\fermata \bar "|." }
        \tonIIIbf
        %\tonIIIdf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'  
        {
          e1. fis2. g fis e 
          fis8 [fis e e] fis [fis e e] g4 g8 [g] fis4. fis8 g4 g fis4. fis8 g [g g g] a4 g8 [g] fis4. fis8 g4 g fis2 }
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricmode 
   { \set associatedVoice = #"soprano"
     Jé4 -- ru -- sa -- lem_! \breve. __ 
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { %\set associatedVoice = #"soprano"
     \once \override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
     \repeat unfold 3 {\skip2.} En8 toi, Dieu ras -- sem -- ble tes en -- fants4 dis8 -- per -- sés,4.
     Jé8 -- ru4 -- sa -- lem,4. pour8 cé -- lé -- brer le Nom4 du8 Sei -- gneur,4. Jé8 -- ru4 -- sa -- lem_!2
   }
   \new Staff
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          b2. a1. e'2. d c
          d8 [d c c] d [d c c] e4 e8[e] d4. d8 e4 e d4. d8 e8 [e e e] fis4 e8 [e] d4. d8 e4 e d2}
        \tonIIIbh
        %\tonIIIdh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        {
          e2. a, d a d <a a'>\fermata
          d8-> [d g g] d-> [d <g, g'> <g g'>] <a a'>4 <a a'>8 [<a a'>] d4. d8 a'4 a d,4.\breathe
          d8 a'8-> [a a a] <d, d'>4 a'8 [c] d4. <d, d'>8 a'4 c d2\fermata}
      }
   >>
>>