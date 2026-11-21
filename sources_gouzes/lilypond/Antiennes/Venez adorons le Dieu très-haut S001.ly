\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff 
<<  \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "soprano" 
       { \voiceOne \relative c'' 
         { \clef "treble" \key g \major \cadenzaOn
           \tempo 2 = 84 e,2 fis g4 a b2 b a2. g4 fis2 \breathe\allowBreak
           g a a4 a g2 g4 g fis2 fis \bar "|." 
         } \tonVIIaf % Pas de ton dans l’original
       }
       \new Voice = "alto" 
       { \voiceTwo \relative c' 
         {
           cis2 d d4 d g2 g fis 2. d4 d2 d d d4 d d2 d4 d d2 d
         } 
       }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
    { \set associatedVoice = #"alto"
      Ve2 -- nez, a4 -- do -- rons2 le Dieu2. Très-4 Haut2 qui fait de4 Ma -- rie2 sa4 de -- meu2 -- re.
    }
    \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "ténor" 
       { \voiceOne \relative c' 
         { \clef "bass" \key g \major \cadenzaOn
           a2 a b4 c d2 d c2. b4 a2 \breathe b c c4 c b2 b4 b a2 a
         } \tonVIIah
       }
       \new Voice = "basse" 
       { \voiceTwo \relative c' 
         {
           a,2 d d4 d d2 d d2. d4 d2 g fis fis4 fis g2 g4 g d2 d
         } 
       }
    >>
>>