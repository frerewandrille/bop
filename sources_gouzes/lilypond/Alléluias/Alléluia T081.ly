\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 66
          g4 a bes2.-> bes4\resp a bes c2. bes\bar"|"
          \time 2/2 bes4\rest bes a-> (g) g-> (f) g2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 f f2. f4 f f g2 (a4) f2. s4 f f (d) e (d) d2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 c d2. d4 c d ees2 (c4) d2. s4 d c (bes) c (a) bes2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 f bes,2.-> d4\resp f d c2-> (f4) bes2.
          d,4\rest bes' f-> (g) c,-> (d) <g, g'>2\fermata
        } 
      }
   >>
>>