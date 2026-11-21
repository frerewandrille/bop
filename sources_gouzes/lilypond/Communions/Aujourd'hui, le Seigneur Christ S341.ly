\version "2.24.0"

\include "vowel-set.ly"

apostrophe = \once \override LyricText.X-offset = #apostrophe

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \relative c''
     { \clef "treble" \key bes \major \time 1/4 \omit Score.BarLine %\tempo "" 2 = 52
       bes8 a g a g f g4. \breathe bes8 c bes d bes c bes bes2
       \revert Score.BarLine.stencil \bar "|" 
       bes8 a \omit Score.BarLine g a g f g g \breathe d g g bes a f g2\fermata
       \revert Score.BarLine.stencil \bar "|."
       \cadenzaOn bes\breve a8 g4 \breathe c\breve bes8 a4 \breathe \noBreak\bar "|" 
       a\breve bes8 g4 \breathe g\breve a8 [bes] a2 \bar "|."
       \cadenzaOff
     }
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
     Au -- jour --\apostrophe d’hui, le Sei -- gneur Christ ac -- cueil -- le dans la joie du ciel 
     la Vier -- ge Ma -- rie, sa Mè -- re, qui l’ac -- cueil -- lit dans sa chair.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major
          r4-\markup\italic"b.f." d c bes g ees' f ees f2 r4 d c bes g ees'8 d c4 d2
          \cadenzaOn d \breve s8 ees4 ees\breve s8 f4 f\breve s8 ees4 ees\breve s4 d2 \cadenzaOff
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          g8 a bes c d ees d4. d8 c c bes d c c d2
          g,8 a bes c d ees d d c bes c d16 ees f8 d g2
          \cadenzaOn g\breve s8 c,4 \breathe c\breve s8 d4 \breathe d\breve s8 c4 \breathe c\breve s4 d2 \cadenzaOff
        }
      }
   >>
>>