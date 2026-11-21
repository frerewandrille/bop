\version "2.24.0"

\include "vowel-set.ly"
%\include "TonsDef.ly"

\transpose g f
\new ChoirStaff 
<<  \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "soprano" 
       { \voiceOne \relative c'' 
         { \clef "treble" \key g \major \cadenzaOn
           g4 g^> a b b^> c8 [b] a4^> \breathe\allowBreak
           g8 ([a]) b4.^> c8 d4^- c b4.\allowBreak g8 a4 a g2\fermata \bar "|." 
         } \tonVIbf
       }
       \new Voice = "alto" 
       { \voiceTwo \relative c' 
         {
           d4 d d g g g8 [g] fis4 d g4. a8 b4 g g4. g8 fis4 fis d2
       } }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricmode 
    { \set associatedVoice = #"alto"
      Ve4 -- nez, a -- do -- rons le8 Sei -- gneur,4 cri -- ons4. de8 joie4 vers Dieu,4. no8 -- tre4 Sau -- veur.2
    }
    \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "ténor" 
       { \voiceOne \relative c' 
         { \clef "bass" \key g \major \cadenzaOn
           b4 b c d d e8 [d] c4 b8 ([c]) d4. d8 g4 e d4. b8 c4 c b2
         } \tonVIbh
       }
       \new Voice = "basse" 
       { \voiceTwo \relative c' 
         {
           g4 g g g g g8 [g] d4 \breathe g g4. g8 g4 c, d4. d8 d4 d g2 \fermata
       } }
    >>
>>