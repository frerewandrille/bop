\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Dynamics 
   {
          c2 e4 c b2 b4 b g g a a e2 e4 e g 
          g^\> f f e2\!
          e4^\< e e e a2\! a4 a b2 b4 b c^\> b a2 (g) a1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 60
          c2 e4 c b2 b4 b g g a a e2 e4 e g\resp 
          g f-> f e2\fermata\bar"|"\tempo "Lent" 
          e4-> e e-> e a2 a4 a b2 b4 b c-> b a2 (g) a1\fermata
          \bar"|."
        } \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          a2 a4 a g2 g4 g e e e e d2 b4 b c c d c b2
          c4 c d d e2 e4 e f2 f4 f e e e1 e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le Fils de l’hom -- me n’est pas ve -- nu pour ê -- tre ser -- vi, 
      mais pour ser -- vir
      et don -- ner sa vie en ran -- çon pour la mul -- ti -- tu -- de.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e2 c4 e d2 d4 d b b c c b2 b4 b a a a a gis2
          a4 a a a a2 a4 a a2 a4 a a b c2 (b) c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 f g2 g4 g g g f f g2 g4 g f\resp e d-> d e2\fermata
          a,4-> a b-> b c2 c4 c d2 d4 d e-> e e1 a,\fermata
        } \tonIVah
      }
   >>
>>