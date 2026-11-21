\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2. = 76
          b2 d4 c2 b4 g2 a4 b2.\resp g2 g4 g2. b a\fermata
          \bar"|."
        } \tonVIIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 fis4 a (g) fis e2 fis4 g2. d2 d4 e2. g4 (fis e) fis2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Tes pa -- roles, ô mon Sei -- gneur, sont Es -- prit et Vie.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 e2 d4 c2 c4 d2. b2 b4 c2. d d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 b4 a2 b4 c (b) a g2.\resp g2 g4 c,2. <g g'> d'\fermata
        } \tonVIIfh
      }
   >>
>>