\version "2.24.0"
%\include "TonsDef.ly"


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo "Léger" 2. = 54
          a4 f2 g4 a2 a4 bes2 bes4 a2. g \breathe\allowBreak
          c4^> a bes c2 c4 bes2 bes4 a2. g \bar"|."
        }\tonVIaf
        %\tonVIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 c2 e4 f2 f4 f2 f4 f2. e a4 f g a2 a4 e2 e4 f2. e
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Mon âme a soif du Dieu de vi -- e_! Quand le ver -- rai_- je face à fa -- ce_?
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          c4 a2 c4 c2 c4 d2 d4 c2. c c4 c c c2 c4 c2 c4 c2. c
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f2 c4 f2 f4 bes2 bes4 f2. c\breathe
          f4_> a g f2 f4 g2 g4 f2. c
        } \tonVIah
        %\tonVIhh
      }
   >>
>>