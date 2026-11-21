\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     g8 [b] c4 d8 [c] d [e] d4. c8 d4 e8 [c] c([d]) d4
     a4 a8 [c] c4 b8 [c] d [c] c4 a8 [g] a [c] c4.
     a8^\ppp^\< a [a] a [a] a4\! a8 [a] 
     a4^\> a8 [a] c ([a]) a2\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Paisible, aérien" 4 = 76
         g8 [b] c4 d8 [c] d [e] d4. c8 d4 e8 [c] c([d]) d4\fermata\resp
         a4 a8 [c] c4 b8 [c] d [c] c4 a8 [g] a [c] c4.\resp
         a8 a [a] a [a] a4\! a8 [a] 
         a4^\markup{\italic "rall."} a8 [a] c ([a]) a2\fermata
         \bar"|."
       } \transpose b a \tonVIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g8 [g] g4 fis8 [g] fis [e] fis4. g8 a ([b]) b [g] g4 a
         g fis8 [g] fis ([g]) fis [g] d [e] fis4 e8 [e] 
         e16 [(fis) g8] a4.
         a8 g [g] g [g] fis4 fis8 [fis] g4 g8 [g] fis ([g]) fis2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Lais -- sez_- moi re -- gar -- der le ciel 
     plu -- tôt que la ter -- re,
     pour  qu’au mo -- ment de me mettre en rou -- te
     vers le Sei -- gneur,
     je sui -- ve le che -- min de la vie é -- ter -- nel -- le.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c''
        { \clef "bass" \armure \cadenzaOn
          g8 [fis] e4 d8 [e] d [c] d4. e8 fis4 g8 [e] e4 fis
          e d8 [c] d ([e]) d [c] a16 [(b) c8] d4 c8 [c] c16 [(d) e8] e4.
          e8 e [e] e [e] d4 d8 [d] c4 c8 [c] d ([e]) d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [g] g4 g8 [g] g [g] a ([b16 c] d4) d4 c16 [b a8] d,4 d\fermata\resp
          a'8 ([g]) fis [e] d4 d8 [e] fis [e] d ([e16 fis]) 
          g8 [c16 (b)] a8 [a16 (b)] c4.\resp
          c8 c [c] b [c] a4 a16 [(g) fis8] e4 e8 [e] d4 d2\fermata
        } \transpose b a \tonVIIch
      }
   >>
   \new Lyrics \lyricsto "basse"
   {
     \repeat unfold 8 { \skip4 } 
     plu -- tôt que la ter -- re,
   }
>>