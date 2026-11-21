\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \tempo  2. = 54\cadenzaOn
          b2. a2 \breathe a4 c^> c c b2. g\breathe g2 g4 g^> g a b2.\fermata
          \bar "|."
        } \transpose a b \tonVIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          g2. fis2 fis4 a a a d,2. c e2 e4 e e e g2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Sei -- gneur, tu es ma lou -- an -- ge dans la grande as -- sem -- blée.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4\cadenzaOn
          d2. d2 d4 e e fis g2. e c2 c4 c c c d2.
        } \transpose a b \tonVIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g2. d2 \breathe d4 a'_> a a b2. c\breathe c,2 c4 c_> c c g'2.\fermata
        }
      }
   >>
>>