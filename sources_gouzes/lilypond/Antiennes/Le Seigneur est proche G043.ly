\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e b,
\new ChoirStaff
<<\new Staff = "femmes" \with {\remove Time_signature_engraver }
   <<
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif, léger"
         a8 [g a b] c4 (b) a4.\resp c8 b4. a8 g [g] a2\fermata
         \bar"|."
       } \tonIIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e8 [e e g] g2 e4. a8 e4. e8 e [e] e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur est pro -- che_: ve -- nez, a -- do -- rons_- le_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c8 [b c d] e4 (d) c4. e8 d4. c8 b [b] c2
        } \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a8 [e a g] c,4 (g') a4.\resp a8 a4. a8 e [e] a2\fermata
        } 
      }
   >>
>>