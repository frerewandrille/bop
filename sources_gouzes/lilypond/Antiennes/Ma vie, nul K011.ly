\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose a g
\new ChoirStaff
<< \new Dynamics 
   {
     a2^\< e'2. e4 e\! d e2
     b4 b c2^\> d4 d c2 (b)\! b1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 3/4 \cadenzaOn \tempo  2 = 60
          a2 e'2. e4 e-> d e2\fermata\breathe\allowBreak
          b4 b c2 d4 d c2 (b) b1\fermata\bar "|."
        }\tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e2. e4 f a gis2 e4 e e2 f4 f e1 e
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ma vie, nul ne la prend, mais c’est moi qui la don -- ne_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4 \cadenzaOn
          c2 b2. b4 a a b2 gis4 gis a2 a4 a a1 gis!
        }\tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 g2. g4 f_> f e2\fermata\breathe e4 e a,2 d4 d e1 e\fermata
        }
      }
   >>
>>