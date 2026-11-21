\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très calme"
         g2 4 g-> (a) bes c2. \allowBreak r4 bes a bes2-> 4 a-> (g) f g2. d\bar"|"
         d'2-> 4 d-> (c) bes c2-> 4 a2.\resp bes2-> 4 g2-> a4 g2-> f4 g2.\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto"\with { \consists "Balloon_engraver"
                                \override BalloonText.annotation-balloon = ##f }
     { \voiceTwo \relative c'
       { 
         d2 4 2 4 ees2 (d4) 
         <c \balloonText #'(2 . -2)\markup { "" } >2 4 d2 4 ees2 4 d (c bes) a2.
         bes'2 4 g2 4 2 4 f2. 4 (ees) d ees2 4 d2 4 2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tous d’un mê -- me cœur de -- meu -- raient dans la pri -- è -- re
     dans l’at -- ten -- te de l’Es -- prit que Jé -- sus a -- vait pro -- mis.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 4 2 4 g2. 
          <g \balloonText #'(2 . 2)\markup { "" } >2 4 2 4 a2 4 bes (a g) fis2.
          f'!2 4 ees2 4 2 d4 c2. bes2 4 2 c4 bes 
          <a \balloonText #'(1.5 . 2.5)\markup { "" } >2 b2.
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2-> 4 f2-> 4 ees2. 2 4 d2-> 4 c2-> 4 bes2 (c4) d2.
          bes4-> (c) d ees2-> d4 c-> (d) ees f2 (ees4)\resp
          d-> (c) bes ees-> (d) c d2-> 4 g2.\fermata
        } 
      }
   >>
>>