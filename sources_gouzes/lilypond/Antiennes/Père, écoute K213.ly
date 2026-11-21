\version "2.24.0"
%\include "TonsDef.ly"

\transpose b a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          b2 b2.\fermata\breathe b4 a2 a1 c4 c e2 b b4 a b2.\fermata \allowBreak \breathe
          b4 a2. a4 c c b2 g g^\markup\italic"rall." a b1 \bar "|."
        }\tonVIff 
        %\tonVIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          g2 g2. g4 fis2 fis1 a4 a g2 fis e4 e g2.
          g4 fis2. fis4 e e g2 e e fis g1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Pè -- re, é -- cou -- te la pri -- è -- re de ton Fils_! 
     Re -- gar -- de le vi -- sa -- ge de ton Christ_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
          d2 d2. d4 d2 d1 c4 c b2 b c4 c d2.
          d4 d2. d4 c c e2 b c c d1
        }\tonVIfh 
        %\tonVIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g2 g2. \fermata \breathe g4 d2 d1 a'4 a e2 d d4 d g2.\fermata \breathe
          g4 d2. d4 a'4 a e2 e e d g1
        }
      }
   >>
>>