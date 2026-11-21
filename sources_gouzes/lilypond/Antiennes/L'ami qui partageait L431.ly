\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Très lourd"% 2 = 52
          e2 e2.^\< e4 e e e d e2 e4 e f2 f4 a e1\!\bar"|"
          c'2. c4 b b a2 a4 a g1-> a\fermata
          \bar"|."
        } \tonIVef
        %\tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 d2. d4 c c d d c2 b4 b c2 c4 b c1
          e2. e4 e e c2 a4 a b1 c
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      L’a -- mi qui par -- ta -- geait mon pain m’a li -- vré à la mort_!
      Pè -- re, sau -- ve_- moi de cette heu -- re_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 b2. b4 a a b b a2 a4 a a2 a4 a a1
          c2. c4 d d e2 d4 d e1 e
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 g2. g4 f f g g f2 e4 e d2 d4 d a1
          a'2. a4 g g f2 f4 f e1-> a,\fermata
        } \tonIVeh
        %\tonIVch
      }
   >>
>>