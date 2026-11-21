\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Très lent et pesant" 2 = 44
          g4 g f f g g d d f f g g d2\fermata\bar"|"
          g4 g g2\fermata\resp g4 g bes2 (a4) bes^\> c c g2\fermata\!
          \bar"|."
        } \tonIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d d d ees ees d d d d ees ees d2 d4 d e2 e!4 e g2. g4 g g g2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Je suis des -- cen -- du dans les té -- nè -- bres de la mort. 
      Au ma -- tin, que j’en -- ten -- de ton a -- mour_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 bes a a c c bes bes a a c c bes2 
          bes4 bes c2 c4 c d2 (c4) d e e d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g d d c c g' g d d c c <g g'>2\fermata
          g'4 g c,2\fermata\resp c4 c g'2. g4 c, c <g g'>2\fermata
        } \tonIIbh
      }
   >>
>>