\version "2.24.0"

%\include "TonsDef.ly"
% \include "vowel-set.ly"
% \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/8 \omit Score.BarLine %\tempo "" 2 = 52
          \partial8 g8 g4-> a8 bes4-> d8 c4-> a8 bes4-> \breathe
          d8 bes4-> bes8 a4-> g8 g4-> f8 g4.
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \transpose a g \tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial8 d8 d4 f8 f4 bes8 a4 f8 f4 f8 g4 g8 ees4 g8 d4 d8 d4.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor
          \partial8 bes8 bes4 c8 d4 f8 ees c4 d d8 d4 d8 c4 bes8 bes a4 bes4.
        }\cadenzaOn \transpose a g \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial8 g8 g4-> f8 bes,4-> bes8 f'4-> f8 bes,4-> \breathe
          bes8 g'4-> g8 c,4-> ees8 d4-> d8 g,4.
        }
      }
   >>
>>