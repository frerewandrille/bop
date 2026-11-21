\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 69
         a2.\espressivo a\espressivo \resp 
         d4-> d c c-> c c bes2-> a4 a2.\fermata\bar"||"
         a\breve*1/8 a2\fermata 
         a4-- a-- a2 a\fermata\bar ".|:-|"\time 3/4\break
         d4 c \bar"|" c c c \bar"|" bes2 a4 \bar"|"\noBreak a \bar":|."
         a\breve*1/8 a2 a4 a a2.\fermata\bar ".|:-|"\time 3/4
         d4 c \bar"|" c c c \bar"|" bes2 a4 \bar"|" a\fermata \bar":|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2. e d4 bes' g a a a g2 e4 f2.
         f\breve*1/8 g2 g4 f e2 e d4 g a a a g2 e4 f
         f\breve*1/8 g2 g4 f e2. d4 g a a a g2 e4 f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Saint, saint, saint, le Sei -- gneur, Dieu de l’u -- ni -- vers_!
     "Le ciel et la terre sont rem" -- plis de ta gloi -- re.
     Ho -- san -- na au plus haut des cieux.
     "Béni soit celui qui vient au" nom du Sei -- gneur.
     Ho -- san -- na au plus haut des cieux.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2. cis d4 d e f f f d2 cis!4 d2.
          d\breve*1/8 e2 e4 d cis!2 cis 
          d4 e f f f d2 cis!4 d
          d\breve*1/8 e2 e4 d cis!2.
          d4 e f f f d2 cis!4 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2. a'\resp bes4-> bes c f,-> f f g2-> a4 d,2.\fermata
          d\breve*1/8 a'2\fermata a4-- a-- a2 a\fermata
          bes4 c f, f f g2 a4 d,
          d\breve*1/8 a'2 a4 a a2. \fermata
          bes4 c f, f f g2 a4 d,\fermata
        } 
      }
   >>
>>