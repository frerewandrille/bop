\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 2/4 \omit Score.BarLine \tempo "Vif et marqué"% 2 = 52
          a8 a bes4. a8 bes4 a-> a8 a bes4 bes \breathe c4-> c a2 \breathe a a4-> a8 a bes2\fermata
          \revert Score.BarLine.stencil \bar "|."
          \cadenzaOn bes\breve a bes4 \bar"|"\noBreak bes\breve c a4 \bar"|"\noBreak 
          a\breve a bes4\bar"|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          fis8 fis g4. fis8 g4 fis fis8 fis g4 g g g f!2 f fis4 fis8 fis g2
          \cadenzaOn g\breve fis g4 g\breve g f4 f\breve fis g4
        }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   {
     Gloire à toi, ô Christ, notre es -- pé -- ran -- ce, 
     gloire à toi, Christ, no -- tre sa -- lut_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 2/4
          d8 d d4. d8 d4 d d8 d d4 d e e c2 c d4 d8 d d2
          \cadenzaOn d\breve d d4 d\breve e c4 c\breve d d4
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          d8 d g4. d8 g4 d_> d8 d g4 g \breathe
          c,_> c f2\breathe f d4_> d8 d <g, g'>2\fermata
          \cadenzaOn g'\breve d g4 g\breve c, f4 f\breve d g4
        }
      }
   >>
>>