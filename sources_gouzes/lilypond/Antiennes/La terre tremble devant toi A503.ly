\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key ees \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose ees c
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  2. = 72
         ees4-> d c bes2-> 4 c2 d4 ees2.\resp
         2 f4 bes,2 ees4 (d->) c2 bes2.\resp 
         4-> g c bes-> 4 \allowBreak aes g-> f2 ees2.\resp
         ees'4-> 4 d ees4. (d8 c4) \resp
         bes4 4 a bes4. (aes8 g4)\resp
         f ees2 d4 ees2.
         \bar"|."
       } \transpose c bes, \tonVff
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
     { \voiceTwo \relative c''
       { 
         bes4 4 g g2 4 ees2 f4 g2. 2 a4 bes (a) g (f2) 
         <ees \balloonText #'(-2 . -2)\markup { "" } >4 d2.
         4 ees g g g ees4 4 4 (d) ees2.
         bes'4 4 4 2 (aes4) f f f f2 (ees4) c c2 bes4 2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La ter -- re trem -- ble de -- vant toi, ô Sei -- gneur no -- tre Dieu,
     quand tu te lè -- ves pour nous sau -- ver_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c''
        { \clef "bass" \armure \cadenzaOn
          g4 f ees d2 4 c2 aes4 bes2. 2 c4 d2 bes4~ 2 
          <a \balloonText #'(-2 . 4)\markup { "" } >4 bes2.
          4 4 ees d d c bes4 4 (aes) g2.
          g'4 g f g2 (ees4) d c c d2 (bes4) aes g (aes) f g2.
        } \transpose c bes, \tonVfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees4-> bes' c g2-> 4 aes (g) f ees2.\resp
          g2 f4 d2 ees4 (f->) f2 bes,2.\resp
          4-> ees c g'-> g aes bes4-> 4 (bes,) ees2.\resp
          4-> 4 bes' ees,2 (aes4)\resp
          bes f f <bes, bes'>2 (ees4)\resp
          f c (aes) bes ees2.
        } 
      }
   >>
>>