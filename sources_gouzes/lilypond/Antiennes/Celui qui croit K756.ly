\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 66
          d4 d-> d c-> d ees-> c d2 bes\fermata\resp 
          bes4 bes a2 a4 a g2 g f g1\fermata
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g g g g a f2 g g4 g ees2 ees4 ees d2 d d d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ce -- lui qui croit en ma pa -- ro -- le 
      est pas -- sé de la mort à la vie.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 bes bes a bes c c bes2 bes bes4 bes c2 c4 c bes2 a a bes1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g-> g g-> g c,-> f bes,2 ees\fermata\resp 
          ees4 ees c2 c4 c d2 d d <g, g'>1\fermata
        } \tonIIah
      }
   >>
>>