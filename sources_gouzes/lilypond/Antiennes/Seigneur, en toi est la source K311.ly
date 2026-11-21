\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo "Calme" 2. = 66
          a4 g2\fermata\breathe\allowBreak g4 bes^> bes bes g2 g4 c2 c4 a2.\breathe\allowBreak
          d4^> d c bes2. (c) a \allowBreak
          \oneVoice r4\voiceOne a a a2. a4^> a a bes2. a\fermata\bar"|."
        }\transpose b a \tonVIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 e2 e4 g g g e2 e4 a2 a4 fis2. a4 a a g1. e2.
          s4 e e f2. f4 f f f2 (e4) f2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, en toi est la sour -- ce de la vie_: 
      tu nous a -- breu -- ves au tor -- rent de tes dé -- li -- ces_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          c4 c2 c4 d d d c2 c4 e2 e4 d2. d4 d d d2. (e) cis 
          s4 cis! cis d2. d4 d d d2 (c4) c2.
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 c2\fermata\breathe c4 g'_> g g <c, c'>2 <c c'>4 <a a'>2 q4 <d d'>2. \breathe
          fis4_> fis fis g2. (e) a 
          \oneVoice r4\voiceTwo a a a2. a4_> a a g2. f\fermata
        }\transpose b a \tonVIfh
      }
   >>
>>