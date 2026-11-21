\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif" 4 = 108
         a8 [a] g [a] b4 
         b\breve*1/16 a8 [b] 
         c4^> (b8 [c b a] b4^> a8 [g]) a4 \resp
         a\breve*1/16 b8 g4 \allowBreak fis8 [g] a4\fermata\resp
         a8^> [b] c4^>^\> (b8 [c b a] b4-> a8 [g]) a2\fermata\!
         \bar"|."
       } \transpose b a \tonVIIcf % Pas de ton dans l’original
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         fis8 [fis] e [fis] g4 
         g\breve*1/16 g8 [g] g1 ( fis8 [e]) fis4
         fis\breve*1/16 fis8 e4 e8 [e] fis4 
         fis8 [g] a4 (g2.~g8 [d]) fis2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ré -- jou -- is -- sez_- vous 
     "et soyez dans" l’al -- lé -- gres -- se,
     "car votre nom est" ins -- crit dans les cieux, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [d] d [d] d4 
          d\breve*1/16 c8 [d] e4 (d8 [e d c] d4-> c8 [b]) c4 
          c\breve*1/16 d8 b4 a8 [b] d4 
          d8 [d] d4.(e8 [d c] d4-> c8 [b]) d2
        } \transpose b a \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d8 [d] d [d] g4 
          g\breve*1/16 g8 [g] g1 (d8 [e]) d4 \resp
          d\breve*1/16 d8 e4 e8 [e] d4\fermata\resp
          d8-> [d] d4-> (g1) d2 \fermata
        } 
      }
   >>
>>