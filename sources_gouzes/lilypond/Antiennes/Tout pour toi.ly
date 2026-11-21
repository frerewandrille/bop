\version "2.24.0"
 
%\include "TonsDef.ly"
\include "vowel-set.ly"

resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn 
          a4-> b c (b8 [a] b2) g a2.\fermata\resp
          e4 f!2 e e\fermata\bar "|"
          e e4-> e e-> fis g (e) e2\fermata \resp
          a4-> b c-> (b8) [a] b4 (g) a2 a a1\fermata\bar "|."
          \bar "|."
        } \tonVIIhf %\tonVIIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          e4 e a (e g2) e fis?4 (e8 [d] e4)\fermata c d (c8 [b]) b2 c
          c b4 b c d b2 c e4 e a (e8) [e] g4 (e) fis2 e fis1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Tout pour toi, Sei -- gneur, et rien pour nous.
      Au soir de no -- tre vi -- e, nous se -- rons ju -- gés sur l’a -- mour.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
           c4 d e (d8 [c] d2) d d4 (c8 [b] c4) \fermata a a2 a4 (fis8 [g]) a2
           a g4 g a a g2 a c4 d e (d8) [c] d2 d c d1
        } \tonVIIhh %\tonVIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          a4-> a a2 (g) b a2.\fermata\breathe a4 d,2 e a,\fermata
          a e'4-> e a, d e2 a,\fermata\breathe a'4-> a a4.-> a8 g4 (b) a2 e d1\fermata
        }
      }
   >>
>>