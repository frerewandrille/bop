\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rallentendo" )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff
<< \new Dynamics 
   {
     gis8 a2 b c4\< c\> c2\!  \silC 8 c [b] c4 b8 [a] gis!2 a b
     c\breve b8 c4 8 [b] c4. b8 \agauche a8^\rall\> ([b16 c]) b8 [a] b2\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Marcato"
         gis8 a2 b c c \resp \silC \tempo "Vif" c8 c [b] c4 b8 [a] gis!2 a b\resp
         c\breve b8 c4\resp 8 [b] c4. b8 a8-. ([b16-. c-.]) b8 [a] b2\fermata
         \bar"|."
       } \transpose g a \tonIIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e8 2 2 g g s8 g g [g] 4 8 [e] 2 e g 
         g\breve 8 4 8 [g] 4. 8 e8 ([g]) g [e] g2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que Dieu se lè -- ve_! Ses en -- ne -- mis se -- ront dis -- per -- sés_!
     "Les justes jubilent devant la face" de Dieu,
     ils s'e -- xaltent et dan -- sent de joie_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 c2 d e e \silC 8 e [d] e4 d8 [c] b2 c d 
          e\breve d8 e4 8 [d] e4. d8 c ([d16 e]) d8 [c] d2
        } \transpose g a \tonIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 a2 g c, c\resp s8 8 8 [g'] c,4 g'8 [a] e2 a g\resp
          c,\breve g'8 c,4\resp
          8 [g'] c,4. g'8 a-. ([g16-. c,-.]) g'8 [a] g2\fermata
        } 
      }
   >>
>>