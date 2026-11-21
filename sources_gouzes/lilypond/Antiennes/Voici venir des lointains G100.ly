\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff
<< \new Staff = "femmes"
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2. = 72
         d4 d2 c4 f-> f g a2 a4 c-> c d a2.\resp
         a2 a4 a-> g a b-> (a g) a2\fermata\resp \agauche e4\rall^\> g2. f2 e4 d2.\!\fermata
         \bar"|."
       } \tonIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d4 d2 c4 f f g a2 a4 f f d8 ([e]) f2. f2 f4 f e f g (f e) f2 e4 e2. d2 e4 \small f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci ve -- nir des loin -- tains le Nom du Sei -- gneur, 
     et l’é -- clat de sa gloi -- re rem -- plit l’u -- ni -- vers_!
   }
   \new Staff = "hommes" 
   \with { \consists "Balloon_engraver" \override BalloonText.annotation-balloon = ##f }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d4 d2 c4 f f g a2 a4 c c bes c2. c2 b4 c d c d (c d) c2 c4 b!2. a4 
          <b! \balloonText #'(2 . 2)\markup { "" } >2 a2.
        } \tonIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d2 c4 f-> f g a2 a4 a-> a g f2.\resp
          f2 g4 a-> b a g-> (a b) a2\fermata\resp
          a4 e2. f4 g2 d2.\fermata
        } 
      }
   >>
>>