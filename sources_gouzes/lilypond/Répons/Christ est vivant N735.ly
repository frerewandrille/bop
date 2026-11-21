\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff 
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Rythmé et paisible"
         g4 bes2-> a4 g2-> 4 4-> 4 f g2\fermata\bar"|"
         a4 bes2-> c4 d2-> \allowBreak bes4 c-> (bes) a g2-> (f4) g2\fermata\bar"|"
         a4 bes2-> c4 d2-> \resp bes4 c-> (bes a) g2-> (f4) g2\fermata
         \bar"|."
       } \tonIIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 f2 4 d2 4 e d d d2 f4 2 a4 bes2 g4 g (f) f d (e! d) d2
         f4 2 a4 bes2 g4 g (f2) d4 (e! d) d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Christ est vi -- vant, il règne à ja -- mais_!_
     An -- non -- cez_- le à tous les peu -- ples_!_
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 d2 c4 bes2 4 c a a bes2 c4 d2 f4 f (d) d e (d) c bes (c a) bes2
          c4 d2 f4 f (d) d e! (d c) bes (c a) bes2
        } \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 d2-> f4 g2-> 4 c,-> d d g2\fermata
          f4 bes,-> (d) f bes2-> g4 c,-> (d) f g-> (c, d) g2\fermata
          f4 bes,-> (d) f bes2-> \resp g4 c,-> (d f) g-> (c, d) g2\fermata
        } 
      }
   >>
>>