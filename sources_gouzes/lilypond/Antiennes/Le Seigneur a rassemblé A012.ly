\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\transpose g f
\new ChoirStaff 
<<  \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "soprano" 
       { \voiceOne \relative c'' 
         { \clef "treble" \key g \major \cadenzaOn
           \tempo "Calme mais vivant" 
           g4 g g8 [fis] g [a] b4 c b4. (a8) g4 \breathe\allowBreak
           b c d d c c b2 \bar "|" d4 e e d d b2\fermata \bar "|." 
         } \transpose f g \tonVIdf
       }
       \new Voice = "alto" 
       { \voiceTwo \relative c' 
         {
           d4 d d8 [d] d [d] g4 g g4. (fis8) d4 g g g g g fis g2 g4 g g g fis g2
       } }
    >>
    \new Lyrics \lyricmode 
    { \set associatedVoice = #"alto"
      Le4 Sei -- gneur8 a ras -- sem -- blé4 son peu2 -- ple4 comme un ber -- ger son trou -- "peau :"2 
      Ve4 -- nez a -- do -- rons_- le.2
    }
    \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "ténor" 
       { \voiceOne \relative c' 
         { \clef "bass" \key g \major \cadenzaOn
           b4 b b8 [a] b [c] d4 e d4. (c8) b4 d d d d e d d2 b4 c c a a g2
         } \transpose f g \tonVIdh
       }
       \new Voice = "basse" 
       { \voiceTwo \relative c' 
         {
           g4 g g8 [g] g [g] g4 c, d2 g4 \breathe
           g a b b a a g2 g4 c, c d d g2 \fermata
       } }
    >>
>>