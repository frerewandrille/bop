\version "2.24.0"
%\include "TonsDef.ly"


\transpose c a,
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key ees \major \time 3/4 \cadenzaOn \tempo "Lourd, pesant" 2 = 58
          g2 aes2. aes4 aes^> aes aes1 f2 f g\fermata\breathe\allowBreak
          c2 c4 c c2. c4 bes2 g g\fermata\breathe\allowBreak
          d'2 d4 d d2^> c c1 bes2 c1\fermata\bar"|."
        }\transpose a c' \tonIVbf
        %\transpose g bes \tonIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 ees2. ees4 ees ees d1 d2 d d f f4 f f2. f4 g2 ees ees g g4 g f2 f ees1 f2 g1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ma vie é -- tait au bord des En -- fers, dé -- jà comp -- té par -- mi les morts_; 
     et je cri -- ais vers toi, Sei -- gneur_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key ees \major \time 3/4 \cadenzaOn
          bes2 c2. c4 c c c1 c2 c b c c4 c d2. d4 d2 c c bes bes4 bes c2 c c1 d2 ees1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 f2. f4 f_> f f1 aes2 aes g\fermata\breathe
          aes aes4 aes aes2. aes4 g2 c, c\fermata\breathe
          g' g4 g aes2_> aes g1 g2 c,1\fermata
        }\transpose a c' \tonIVbh
        %\transpose g bes \tonIIdh
      }
   >>
>>