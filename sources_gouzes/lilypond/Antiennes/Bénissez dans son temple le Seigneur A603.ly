\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose bes g
\new ChoirStaff  %\with { instrumentName = #"5" }
<< \new Staff 
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key bes \major \time 2/2 \tempo  2 = 88
          bes1 bes2 d c bes a1 g \breathe d' ees2 c~c d c1 bes\fermata \breathe
          d2 d ees ees f1 d2 \breathe d c bes a1 g d'~d2 ees c1 \noBreak bes \fermata \bar "|." }
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'  
        {
          f1 g2 a4 (bes) a2 g g (fis) g1 f bes2 a~a bes g (a) f1 f2 f g g a1 f2 f g g fis1 g \breathe 
          f~f2 g bes (a) f1 
        }\cadenzaOn %\transpose a d' \tonVIaf
        \transpose c bes, \tonVIIIdf
      }          

   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Bé1 -- ni2 -- sez dans son Tem1 -- ple le Sei2 -- gneur1 d’Is2 -- ra1 -- ël,
     qui2 donne à son peu1 -- ple2 force et puis -- san1 -- ce. Al1. -- lé2 -- lu1 -- ia_!
   }
   \new Staff
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key bes \major \time 2/2
          d1 d2 f f d ees (d) d1 d g2 f~f f ees (c) d1 d2 d bes bes c1 d2 d ees d d1 bes d~ d2 bes f'1 d}
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          bes1 g2 d f bes, c (d) g1 \breathe bes ees,2 f~ f d ees (f) bes,1 \fermata \breathe
          bes'2 bes g g f1 bes2 \breathe bes ees, g d1 ees \breathe bes' ~bes2 g f1 bes\fermata
        }\cadenzaOn %\transpose a d' \tonVIah
        \transpose c bes, \tonVIIIdh
      }
   >>
>>