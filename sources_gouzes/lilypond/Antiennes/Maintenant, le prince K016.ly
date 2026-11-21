\version "2.24.0"
%\include "TonsDef.ly"


%\transpose c d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn \tempo "Vif" 2 = 120
          c4 c a2. a4 c^> c a^> c a2 a4 a d2 c4 c a2.\fermata\bar "|"
          \tempo "Élargir" 4 = 66
          a4 a2 a4 a f^> g a2 a2.\breathe\allowBreak
          d,4 e^> f g1 f2 f e1\fermata\bar"|."
        }\transpose b a \tonIIIef
        %\tonIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          a4 a f2. f4 a a f a f2 f4 f f2 a4 g fis2.
          f4 f2 f4 c d d cis2 cis2. d4 d d d1 d2 d a1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Main -- te -- nant, le prin -- ce de ce mon -- de va ê -- tre ju -- gé_;
     et moi, é -- le -- vé de ter -- re, j’at -- ti -- re -- rai tout à moi_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
          e4 e d2. d4 e e d e d2 d4 d d2 e4 e d2. 
          c4 c2 c4 a a d, e2 e2. f4 g a bes1 a2 b cis1
        }\transpose b a \tonIIIeh
        %\tonIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 a d2. d4 a_> a d_> a d2 d4 c bes2 a4 c d2.\fermata
          f,4 f2 f4 f d_> bes a2 a2. \breathe d4 d_> d d1 d2 a' <a, a'>1\fermata
        }
      }
   >>
>>