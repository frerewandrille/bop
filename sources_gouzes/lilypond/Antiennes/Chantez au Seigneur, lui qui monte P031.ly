\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key fis \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
         e4 a-> gis a b2 a4 cis2-> b4 b2.\fermata\resp
         b2 b4 b-> (cis) b a2^\markup{\italic rall.} b4 a2.\fermata\resp
         a2 gis4 a-> (b a) fis2 fis4 a2-> gis4 a2.~ a4 b4\rest\bar "|"
         a4^\f a2 fis4 gis2\resp gis4 a2 a4 gis2\resp
         fis4^\p fis2 d4 e2\resp e4 fis2 fis4 e2.\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e e e e2 e4 a2 fis4 gis2. 
         gis2 gis4 gis (a) gis fis2 fis4 e2.
         fis2 eis4 fis2. dis2 dis4 fis2 dis!4 fis2.~ fis4 s4
         fis4 fis2 dis!4 e2 e4 e2 e4 e2 cis4 d2 d4 b2 b4 d2 d4 b2.
       }  \transpose bes a \tonVIIIbf
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Chan -- tez au Sei -- gneur, al -- le -- lu -- ia,
     lui qui mon -- te sur les cieux
     et s’é -- lè -- ve sur le cou -- chant_!
     Al -- le -- lui -- a, al -- le -- lu -- ia_!
     Al -- le -- lui -- a, al -- le -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 cis' b cis d2 cis4 e2 dis4 e2.
          e2 e4 e2 e4 cis
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(2 . 3)\markup { "" } >2
          cis2.
          cis2 cis4 cis (dis cis) b2 b4 cis2 b4 cis2.~ cis4 s4
          cis cis2 b4 b2 b4 cis2 cis4 b2 a4 a2 a4 gis2 gis4 a2 a4 gis2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 a-> e a gis2 a4 a2-> b4 e,2.\fermata\resp
          e2 e4 e-> (a) e fis2 d4 a'2.\fermata\resp
          fis2 cis4 fis2. b,2 b4 fis'2-> b4 fis2.~ fis4 d4\rest
          fis fis2 b4 e,2\resp e4 a,2 a4 e'2\resp
          fis4 d2 fis4 e2\resp e4 d2 d4 e2.\fermata
        } \transpose bes a \tonVIIIbh
      }
   >>
>>