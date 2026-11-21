\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose fis e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2. = 50
          fis2 g4 a a b g2.\resp g2 a4 b2 b4 c (b) c a2.\resp
          a2 b4 c c d b2 (a4) b2 \resp b4 g2 a4 b2 c4 a2.\bar"|"
          a4^\markup\italic"très lent" (fis g) a2 a4 g2 g4 fis2.
          \bar"|."
        } \tonVIIaf %Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d4 d e fis d2. d2 e4 fis2 fis4 g (fis) e fis2.
          fis2 g4 a a b g2. g2 g4 e2 e4 fis2 e4 fis2.
          fis2 (d4) fis2 fis4 g2 e4 d2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le Sei -- gneur ré -- gne -- ra sur le trô -- ne de Da -- vid,
      dans la chair de Ma -- ri -- e, la Mè -- re des vi -- vants_:
      Ve -- nez, a -- do -- rons_- le_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 b4 c c d b2. b2 c4 d2 d4 e(d) c d2.
          d2 d4 d d d d2 (c4) d2 d4 d2 c4 d2 c4 d2.
          c4 (a b) c2 c4 b2 b4 a2.
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d4 d d d g2.\resp g2 g4 g2 g4 g2 g4 d2.\resp
          d2 d4 d d d g2. g2\resp g4 b2 a4 g2 a4 d,2.
          d d2 d4 d2 d4 d2.
        } 
      }
   >>
>>