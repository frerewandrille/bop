\version "2.24.0"
%\include "TonsDef.ly"


\transpose a g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 2/2 \cadenzaOn \tempo "Très large" 2 = 52
          a4 a e' a, b2. \breathe b4 g^>g a^> b g2 e2.\fermata\bar "|"
          e4 e^> e e2 f4 f4 e2.\breathe\allowBreak e4 a2 a4 b c2 b a\fermata\bar "|."
        }\tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e e e2. e4 e e d d e2 e2. e4 e e d2 c4 b c2. c4 d2 e4 f e2 e4 (d) c2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Hom -- me de dou -- leur, bro -- yé par la souf -- fran -- ce, 
      il a é -- té trans -- per -- cé à cau -- se de nos pé -- chés.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 2/2 \cadenzaOn
          c4 c c c b2. b4 b b a a b2 c2. c4 b b a2 a4 a a2. a4 a2 a4 a a2 gis a
        }\tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 a a a g2.\breathe g4 g_> g f_> f e2 <a, a'>2.\fermata
          a'4 g_> g f2 d4 d a2.\breathe a4 b2 c4 d e2 e a,\fermata
        }
      }
   >>
>>