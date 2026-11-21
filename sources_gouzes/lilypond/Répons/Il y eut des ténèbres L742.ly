\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key aes\minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< 
  \new Dynamics 
  {
    ees2 2 2 4 4 fes2\< 4\> 4\! 4 4 ees4.\< 8\> 2.\!
        4^\< 4 4 fes2 \tuplet 3/2 { 4 4 4 } ges2. 4 aes1\f
  }
  \new Staff \with {\remove Time_signature_engraver }
  << %\accidentalStyle neo-modern-voice
    \new Voice = "soprano"
    { \voiceOne \relative c'
      { \clef "treble" \armure \cadenzaOn \tempo "Lourd et sombre" 2 = 50
        ees2-- 2-- 2-- 4 4 fes2. 4 4 4 ees2\fermata 2.\fermata\bar"|"
        4 4 4 fes2 \tuplet 3/2 { 4 4 4 } ges2.-> 4 aes1\fermata\espressivo
        \bar"|."
      } \transpose a aes \tonIVaf
    }
    \new Voice = "alto"
    { \voiceTwo \relative c'
      { 
        ces2 bes ces2 4 4 bes2. 4 4 4 ces2 2. 
        4 4 4 2 4*2/3 ces ces bes2. des4 ees1
      }    
    }
  >>
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "soprano"
  {
    Il y eut des té -- nè -- bres sur la ter -- re, 
    quand les sol -- dats mi -- rent Jé -- sus en croix_!
  }
  \new Staff \with {\remove Time_signature_engraver }
  << \new Voice = "ténor"
     { %\accidentalStyle neo-modern-voice
       \voiceOne \relative c'
       { \clef "bass" \armure \cadenzaOn
         aes2 2 2 4 4 2. 4 g g aes2 2. 4 4 4 2 4*2/3 aes aes aes2. 4 1
       } \transpose a aes \tonIVah
     }
     \new Voice = "basse"
     { \voiceTwo \relative c
       { 
         aes2-- 2-- 2-- 4 4 2. 4 4 4 2\fermata 2.\fermata
         4 4 4 2 \tuplet 3/2 { 4 4 4 } 2.-> 4 1\fermata
       } 
     }
  >>
>>