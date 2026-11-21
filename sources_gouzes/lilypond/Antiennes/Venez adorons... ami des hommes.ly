\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff 
<<  \new Dynamics 
    {
      a8 b2 b\breve*1/16 c8 [b] a [c] b4 (a) g2 \bar "|"  
      g\breve*1/16 a4 (b) g2 
      g\breve*1/16 fis4. (g8) a4 
      a8^\< [a] a [b] c4.\! (b8) a4\> g fis2\pp \bar "|." 
    }
    \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "soprano" 
       { \voiceOne \relative c'' 
         { \clef "treble" \key g \major \cadenzaOn \tempo "Vif"
           a8 b2^> \resp b\breve*1/16^\markup\italic"accel." c8^> [b] a [c] b4^> (a) g2 \bar "|"  
           g\breve*1/16^\markup\italic"accel." a4^> (b) g2 \resp
           g\breve*1/16^\markup\italic"accel." fis4. (g8) a4 \resp
           a8 [a] a [b] c4.^> (b8) a4 g fis2\fermata \bar "|." 
         } \tonVIIbf % Pas de ton dans l’original
       }
       \new Voice = "alto" 
       { \voiceTwo \relative c' 
         {
           fis8 g2 g\breve*1/16 g8 [g] g [g] g4 (fis) d2 
           d\breve*1/16 d4 (fis) d2 
           d\breve*1/16 d2 d4 d8 [d] d [g] g2 fis4 d d2
         } 
       }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano"
    { 
      Ve -- nez, 
      \once \override LyricText.self-alignment-X = #LEFT
      "adorons le" Christ, a -- mi des hom -- mes. 
      "Il a choisi Domi" -- ni -- que, 
      "pour annoncer l’Évan" -- gi -- le 
      de mi -- sé -- ri -- corde et de paix.
    }
    \new Staff \with {\remove Time_signature_engraver }
    << \new Voice = "ténor" 
       { \voiceOne \relative c' 
         { \clef "bass" \key g \major \cadenzaOn
           d8 d2 d\breve*1/16 e8 [d] c [e] d4 (c) b2 
           b\breve*1/16 c4 (d) b2 
           b\breve*1/16 a4. (b8) c4 c8 [c] c [d] e4. (d8) c4 b a2
         } \tonVIIbh
       }
       \new Voice = "basse" 
       { \voiceTwo \relative c' 
         {
           d,8 g2-> \resp g\breve*1/16 g8-> [g] g [g] d2 g 
           g\breve*1/16 fis4-> (d) g2 \resp 
           g\breve*1/16 d2 d4 \resp 
           d8 [d] d [d] c2-> d4 d d2 \fermata
         } 
       }
    >>
>>