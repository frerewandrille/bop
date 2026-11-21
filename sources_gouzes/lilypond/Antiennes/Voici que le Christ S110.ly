\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff 
<<  \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "soprano" 
       { \voiceOne \relative c'' 
         { \clef "treble" \key g \major \cadenzaOn
           e,2 fis g4 a b2 b a2. g4 fis2 \breathe g a1  g2 g fis1 \fermata \bar "|." 
         } \tonVIIaf
       }
       \new Voice = "alto" 
       { \voiceTwo \relative c' 
         {
           cis2 d d4 d g2 g fis 2. d4 d2 d2 d1 d2 d d1
       } }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricmode 
    { \set associatedVoice = #"alto"
      Voi2 -- ci que4 le Christ2 est né2. pour4 nous.2 Ve2 -- nez1 l’a2 -- do -- rer_!1
    }
    \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "ténor" 
       { \voiceOne \relative c' 
         { \clef "bass" \key g \major \cadenzaOn
           a2 a b4 c d2 d c2. b4 a2 \breathe b c1 b2 b a1
         }  \tonVIIah
       }
       \new Voice = "basse" 
       { \voiceTwo \relative c' 
         {
           a,2 d d4 d d2 d d2. d4 d2 g fis1 g2 g d1\fermata
       } }
    >>
>>