\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e b,
\new ChoirStaff
<< \new Dynamics 
   {
        a4\pp a a8 [b] g4 fis8 [g] a4 \resp
         b8\f\< [c] d4\! (c8 [d] c [b\>]) c4 b a2\!
         \bar"|."
     
   }
   \new Staff = "femmes" \with {\remove Time_signature_engraver }
   <<
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn 
         a4 a a8 [b] g4 fis8 [g] a4 \resp
         b8 [c] d4 (c8 [d] c [b]) c4 b a2\fermata
         \bar"|."
       } \tonIIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 e fis8 [g] e4 e8 [e] e4 e8 [a] a2. 4 gis e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ve -- nez, le -- vez_- vous et veil -- lez, car il vient, le Sei -- gneur_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c8 [b] b4 a8 [b] c4 d8 [e] f4 (e8 [f] e [d]) e4 d c2
        } \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 a a8 [e] e4 8 [e] a4\resp
          a8 [a] 2. 4 e a2\fermata
        } 
      }
   >>
>>