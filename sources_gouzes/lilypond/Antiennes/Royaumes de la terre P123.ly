\version "2.24.0"

% %\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

rall = #(make-dynamic-script 
         (markup #:line ( #:normal-text #:italic "rall." )))

\new ChoirStaff
<< \new Dynamics 
   {
     b\breve c4 (b8 [a] b4 c) b4. b8 c4 (b8 [a]) 
     \once \override DynamicText.X-offset = #0 g4-\rall\> a g2\! \bar"|"        
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
         b\breve c4 (b8-. [a-.] b4-> c-.) b4. b8 c4-> (b8 [a]) g4 a g2 \bar"|"
         b4-.-\markup\italic"pizzicato" c-. d-. (c8 [b] a4-> b8 [c] b4-.-> a-.) b2 \resp
         b\breve a8 b4. c8 d4 (c8 [b] a4->) a-. b2\fermata
         \bar"|."
       } \tonVIif
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g\breve g4 (g8 [g] g4 g) g4. g8 g4. (d8) d4 d d2
         g4 g g1. g2 g\breve g8 g4. g8 g2. g4 g2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \once \override LyricText.X-offset = 0
     "Royaumes de la" ter -- re, chan -- tez le Sei -- gneur_!
     Il s’é -- lè -- ve "au plus haut" des cieux, à l’O -- ri -- ent_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve e4 (d8 [c] d4 e) d4. d8 e4 (d8 [c]) b4 c b2
          d4 e f-. (e8 [d] c4_> d8 [e] d4-._> c-.) d2
          d\breve c8 d4. e8 f!4 (e8 [d] c4_>) c d2
        } \tonVIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve g4 (g8-. [g-.] g4-> g-.) g4. g8 c,4 (d) d d <g, g'>2
          g'4-. g-. g1. g2 \resp g\breve g8 g4. g8 g2. d4-. g2\fermata
        } 
      }
   >>
>>