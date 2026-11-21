\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 2/4 \omit Score.BarLine \tempo 2 = 52
          bes16 bes bes (a bes a) g8 d'16 d c (bes c bes) a8 
          bes16 bes bes (a bes a) g8 a16 a g (f) g4\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \tonIIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d16 d d (c d c) bes8 g'16 g g8 (f) f d16 d d (c d c) bes8 d16 d d8 d4
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major
          d16 d d (c d c) bes8 bes16 bes a (g a g) f8 d'16 d d (c d c) bes8 c16 c bes (a) bes4
        }\cadenzaOn \tonIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g16 g g8 (d) g bes16 bes a (g a g) f8 g16 g g8 (d) g d16 d d8 <g, g'>4\fermata
        }
      }
   >>
>>