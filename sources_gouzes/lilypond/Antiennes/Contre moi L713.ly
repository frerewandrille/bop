\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Allant, détaché" 4 = 116
          g4 g e8 [e e e] g4 g a a g2.\fermata\bar"|"
          g8 [g] a4 a8 [a] c2 c4 a2 a4 gis2 a\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e8 [e e e] d4 d c d e2. 
          e8 [e] fis4 fis8 [fis] g2 g4 fis!2 fis4 e2 e
        }    \tonIVmf
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Con -- tre moi se sont le -- vés de faux té -- moins.
      Ils se sont é -- ga -- rés dans leurs men -- son -- ges.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b c8 [c c c] b4 b a a b2. b8 [b] d4 d8 [d] e2 e4 d2 d4 b2 c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
         e4 e a8 [a a a] g4 g f f e2.\fermata
         e8 [e] d4 d8 [d] c2 c4 d2 d4 e2 a\fermata
        } \tonIVmh
      }
   >>
>>