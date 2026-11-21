\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new Staff \with {\remove Time_signature_engraver }
\new Voice = "soliste" { 
  \relative c'
  {  \armure \cadenzaOn \tempo "Soliste"
     d8 g ([fis g a]) a\breve*1/8 \resp 
     a c8. ([b32 a] d8. [c32 b] \tuplet 3/2 { c8 [b a]) } a4
     \bar"||"
  } 
}
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Refrain "% 2 = 52
         a8 a-> [a a] c-> [b c] a4\fermata\resp d8 d-> [c a] a2.\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         fis8 fis [fis fis] e [e e] fis4 fis8 e [a g] fis2.
       }    
     }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     À toi, la lou -- ange et la gloire é -- ter -- nel -- le -- ment_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "basse"
   { \voiceOne \relative c
    {  \clef "bass" \armure \cadenzaOn 
       d8 d_> [d d] a_> [b a] d4_\fermata\resp d8 a_> [c  e] d2._\fermata
    } 
   }
>>