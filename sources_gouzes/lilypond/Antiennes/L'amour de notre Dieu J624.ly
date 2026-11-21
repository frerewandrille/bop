\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose c bes,
\new ChoirStaff
<< \new Dynamics 
   {
     c4 c b a2 g4 a2 c4 e2 e4 d2\> c4 d2 c4 b2\!
     b4 c c b a a b a2 g4 a2.
     c4 c b a2 c4 e2 c4 d d c d2 c4 b2.
     c4 c b a c\> b a2 (g4) a2.\!
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 92
         c4-> c b a2 g4 a2 c4 e2 e4 d2 c4 d2^\markup\italic"rall." c4 b2\fermata\resp
         b4 c-> c b a-> a b a2-> g4 a2.\bar"|"
         c4-> c b a2 c4 e2 c4 d-> d c d2 c4 b2.\resp
         c4-> c b a-> c b a2^\markup\italic"rall." (g4) a2.\fermata
         \bar"|."
       } \tonIIIif
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver" }
     { \voiceTwo \relative c''
       { 
         a4 a a a2 e4 e2 e4 g2 g4 a2 g4 f (e) d e2
         g4 e e e e f d c 
         \override BalloonText.annotation-balloon = ##f 
         <d \balloonText #'(1 . -2)\markup { "" } >2
         e2.
         a4 a a a2 e4 g2 g4 a a a f (e) d e2.
         e4 e e e f d c (d2) e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     L’a -- mour de no -- tre Dieu nous a é -- té ma -- ni -- fes -- té
     par l’ap -- pa -- ri -- tion de Jé -- sus Sau -- veur.
     Il a dé -- truit la mort et fait res -- plen -- dir la vie,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e4 e d c2 b4 c2 c4 b2 b4 a2 a4 a2 a4 b2
          b4 a a g a a a a 
          \override BalloonText.annotation-balloon = ##f 
          <b \balloonText #'(1 . 2)\markup { "" } >2
          c2.
          e4 e d c2 c4 b2 b4 a a a4 a2 a4 b2.
          a4 a g a a a a (b2) c2.
        } \tonIIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4-> a a a2 e4 a2 a4 g2 g4 f2 e4 d (e) f g2\fermata\resp
          g4 a-> a, b c-> d8 ([e]) f4 e2-> e4 a,2.
          a'4-> a a a2 a4 g2 g4 f-> f e4 d (e) f g2.\fermata\resp
          a4-> a, b c-> d8 ([e]) f4 e2. a,2.\fermata
          
        } 
      }
   >>
>>