\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Dynamics 
   {
     
   }
   \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 60
         e2 4 4 fis2 4 4 g1 4 4 fis2. 4 e1\resp
         4 4 g2. 4 \allowBreak 4 4 a2. 4 d2 d b1\resp
         2 a2. fis4 g2 a b1 1\resp
         2 (a) g2. \allowBreak 4 a2 fis e1\fermata
         \bar"|."
       } \transpose a b \tonIaf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver"
                                 \override BalloonText.annotation-balloon = ##f }
     { \voiceTwo \relative c'
       { 
         b2 4 4 2 4 4 1 e4 4 2 
         <dis \balloonText #'(2 . -2)\markup { "" } >
         e1 c4 4 b2 <b \balloonText #'(1 . -2)\markup { "" } >2 4 4 d2. 4 2 2 1
         g2 fis2. d4 g2 e dis1 1 d2 (fis) e2. 4 2 dis e1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Vo -- yant sa mè -- re de -- bout au pied de la croix 
     et près d’el -- le,
     le dis -- ci -- ple qu’il ai -- mait,
     Jé -- sus dit à sa mè -- re_:
     “Fem -- me, voi -- ci ton fils_!”
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g2 4 4 fis2 4 4 e1 b'4 4 2. a4 g1 e4 4 4 (fis) 
          <g \balloonText #'(1 . 2)\markup { "" } >2 4 4 2. 4 fis2 2 g1
          d'2 2. 4 b2 a fis1 1 d' b2. 4 c2 b4 (a) g1
        } \transpose a b \tonIah
      }
      \new Voice = "basse"\with { \consists "Balloon_engraver"
                                  \override BalloonText.annotation-balloon = ##f }
      { \voiceTwo \relative c
        { 
          e2 4 4 dis2 4 4 e1 g,4 b4 2 
          <b \balloonText #'(2 . 5)\markup { "" } >2 e1\resp
          a,4 4 e'2. 4 4 4 d2. 4 2 2 g,1\resp
          2 d'2. 4 e2 c b1 1\resp
          g2 (d') e2. 4 a,2 b e1\fermata
        } 
      }
   >>
>>