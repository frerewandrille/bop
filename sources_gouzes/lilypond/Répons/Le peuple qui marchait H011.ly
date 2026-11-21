\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/2 }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   << 
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure
         \partial 4 c4 c2. c4 d c c2. c4 a bes a (g2 f e4) f2.
         r2 c'4 c2. c4 d c c2. r4 a4 bes a (g2) f4 f e f2.
         r2 c'4 \time 4/4 c d c4. (bes8 a4) bes a (g~ g f) f (e) \noBreak f1\fermata
         \bar "|."
       }\cadenzaOn \tonVIhf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       {
         a4 a2. f4 f f e2. e4 d d c2 (d4 d8 a c2) c2.
         r2 a'4 a2. f4 f f e2. r4 d d c2 (d4) d8 (a) c4 c c2.
         r2 a'4 f f e2 (d4) d f (d e f) \small g ( \normalsize c,) c1
       }          
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Le peu -- ple qui mar -- chait dans les té -- nè -- bres
     a vu bril -- ler sur lui la lu -- miè -- re du Sa -- lut,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          c4 c2. a4 bes a g2. g4 f f a (c bes a2 g4) a2.
          r2 c4 c2. a4 bes a g2. r4 f4 f a (c bes) a a g a2.
          r2 c4 a bes g2 (fis4) g c (bes a2) g a1 
        }\cadenzaOn \tonVIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f4 f2. f4 bes f c2. c4 d bes f' (e d2 c) f2.
          r2 f4 f2. f4 bes f c2. r4 d bes f' (e d) d c c f2.
          r2 f4 f bes, c2 (d4) g, a (bes c2) c f1\fermata
        }
      }
   >>
>>