\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time 3/8 \cadenzaOn \tempo "Calme" 4. = 60
          fis8 fis ([g) a] a ([g) fis] g4 (a8) b4 \breathe 
          b8 c4 (b8) a ([g) a] b4. \breathe
          \oneVoice r4 \voiceOne b8 b ([a) g] fis2.
          \bar "|."
        } \tonVIIaf %Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d8 d4 d8 d4 d8 d4. g4 g8 g4. d4 d8 g4. 
          s4 g8 g ([d) d] d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Lu -- miè -- re pour les peu -- ples, ô Christ, no -- tre Dieu, nous t’a -- do -- rons_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/8\cadenzaOn
          a8 a ([b) c] c ([b) a] b4 (c8) d4 d8 e4 (d8) c ([b) c] d4. 
          s4 d8 d ([c) b] a2.
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          d8 d4 d8 d4 d8 g4. g4 \breathe 
          g8 c,4 (g'8) g4 g8 g4.\breathe
          \oneVoice r4 \voiceTwo g8 g4 g8 d2.
        }
      }
   >>
>>