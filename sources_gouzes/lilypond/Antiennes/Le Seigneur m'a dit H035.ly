\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time 2/4 \omit Score.BarLine %\tempo "" 2 = 52
          e8 b' a c b4. b8 b4 a b2 \breathe
          a4 b8 c b4 a8 b g4 fis \noBreak e2\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \transpose a b \tonIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          e4 fis g fis e fis e2 fis g4 fis e b e2
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Le Sei -- gneur m’a dit_: "“Tu" es mon Fils. 
      Moi, au -- jour --\apostrophe d’hui, je t’ai en -- gen -- "dré.”"
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major
          b2 b b b \breathe b b b b
        }\cadenzaOn \transpose a b \tonIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          e2-^ e-^ e-^ e-^ e-^ e-^ e-^ e-^\fermata
        }
      }
   >>
>>