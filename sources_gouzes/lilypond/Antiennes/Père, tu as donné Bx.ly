\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose f g
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         f2 (d) e1\resp 2 4 4 f2 4 4 d2 2 \allowBreak f4 4 2. 4 d d e2 2
         r4 e e e f2 4 4 d2 r4 e e e c2 d d\fermata
         \bar"|."
       } \transpose bes f \tonIIaf%\tonIef
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d2 (bes) c1 2 4 4 2 4 4 bes2 a d4 4 2. 4 bes4 4 c2 2
         \allowBreak r4 c c c c2 4 4 bes2 \allowBreak r4 4 4 4 a2 2 2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pè -- re, tu as don -- né à ton peu -- ple u -- ne nour -- ri -- tu -- re d'an -- ge
     et tu lui as pré -- pa -- ré un pain ve -- nu du ciel.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 (g) 1 2 4 4 a2 4 4 f2 2 a4 4 2. 4 g g g2 2
          r4 4 4 4 a2 4 4 f2 r4 g g g e2 f f
        } \transpose bes f \tonIIah%\tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d1 c\resp 2 4 4 a2 4 4 bes2 d2 4 4 2. 4 g4 4 c,2 2
          r4 4 4 4 a2 4 4 bes2 r4 g g g a2 d d\fermata
        } 
      }
   >>
>>