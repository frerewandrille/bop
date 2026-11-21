\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     a4 a8 [a] a4 a b a a2 a 
     fis4. fis8 fis4 fis 
     g fis fis2
     a4^\< a8 [a] a4\! a8 [a] b2 a4^\> a a2 gis\!\bar"|"
     a4 a8 [a] a2 a4 a2^\< gis4 a a2 \allowBreak
     a8 [a]\! c2^\> a4 a b2\!
     b4 b b2 b4 b^\> a2 a4 a a2\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 84
         a4^\mf a8 [a] a4 a b a a2 a\resp 
         fis4.^\markup{\dynamic ppp \italic"(en écho)"} fis8 fis4 fis 
         g fis fis2\fermata\resp
         a4 a8 [a] a4 a8 [a] b2 a4 a a2 gis\bar"|"
         a4^\markup\italic"animé et marqué" 
         a8 [a] a2 a4 a2 gis4 a a2 \allowBreak
         a8 [a] c2 a4 a b2\resp
         b4^\markup\italic"élargir" b b2 b4 b a2 a4 a a2\fermata
         \bar"|."
       } \tonVgf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c'
       { 
         fis4 fis8 [fis] e4 fis g e e2 fis d4. d8 d4 d d d d2
         fis4 fis8 [fis] e4 e8 [e] g2 e4 e e (dis) e2
         e4 e8 [e] fis4 (e) fis e 
         \override BalloonText.annotation-balloon = ##f 
         <d \balloonText #'(1 . -2)\markup { "" } >2
         e4 e2 fis8 [fis] g2 fis4 fis fis2
         fis4 fis g2 g4 g e2 e4 e fis2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ré -- jou -- is_- toi, com -- blée de grâ -- ce, 
     le Sei -- gneur est a -- vec toi_!
     Tu es bé -- nie en -- tre tou -- tes les fem -- mes.
     Toi qui as é -- cra -- sé la tê -- te 
     de l’an -- ti -- que ser -- pent,
     ô Ma -- rie, in -- ter -- cè -- de pour nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d8  [d] cis4 d d d cis2 d a4. a8 a4 a b a a2
          d4 d8 [d] cis 4 cis8 [cis] d2 cis4 cis a2 b
          cis4 cis8 [cis] d4 (cis) d cis 
          \override BalloonText.annotation-balloon = ##f 
          <b \balloonText #'(1 . 2.5)\markup { "" } >2
          cis4 cis2 d8 [d] e2 d4 d d2
          d4 d d 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(2 . 2.5)\markup { "" } >2
          d4 d (cis8 [b]) cis4 cis d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d8 [d] a'4 d, g a a2 d,\resp d4. d8 d4 d g d d2\fermata\resp
          d4 d8 [d] a'4 a8 [a] g2 a4 a fis2 e
          a4 a8 [a] d4 (cis) d cis b2 a4 a2 d8 [d] c2 d4 d b2\resp
          b4 b g2 g4 g a2 a4 a d,2\fermata
        } \tonVgh
      }
   >>
>>