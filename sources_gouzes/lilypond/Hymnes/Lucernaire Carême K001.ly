\version "2.24.0"

resp = { \breathe\allowBreak }

cIs = \relative c'' {
  g\breve fis!4\resp
  fis!\breve  g8 a4 a\breve fis!8 g4 \bar"|"
  g\breve a8 bes4 bes\breve a8 [g] a4\resp
  fis!\breve g8 a\breve g fis!4\fermata\bar "|." }
cIa = \relative c' {
  d\breve d4
  d\breve d8 d4 d\breve d8 d4 
  d\breve d8 g4 g\breve s8 s fis!4
  d\breve d8 d\breve d d4 }
cIt = \relative c' {
  bes\breve a4
  a\breve bes8 c4 c\breve a8 bes4 
  bes\breve c8 d4 d\breve c8 [bes] c4
  a\breve bes8 c\breve bes a4 }
cIb = \relative c' {
  g\breve d4\resp
  d\breve d8 d4 d\breve d8 g4
  g\breve g8 g4 g\breve d8 [d] d4\resp
  d\breve d8 d\breve d d4\fermata }

\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key bes \major \cadenzaOn \tempo "Très souple" 2 = 50
          fis2 g-> a bes4 a2 (g4) fis!2\resp 
          fis! fis e fis!4 g-> a bes a2 (g4) fis!2\bar "|" 
          bes bes4 d-> (c) bes a2 (c4)
          \once \override TextScript.outside-staff-priority = #1
          bes2^\markup\italic"rall."^\> a4 g2\fermata\! \bar "|."
        } \break\cIs 
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        {
          d2 d fis! g4 fis!2 (d4) d2 d d d d4 d fis! g fis!2 (d4) d2
          g2 g4 g2 g4 g2. g2 fis!4 d2
        } \cIa 
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { 
     Joy -- eu -- se lu -- miè -- re,
     splen -- deur é -- ter -- nel -- le du Pè -- re,
     saint et bien -- heu -- reux, Jé -- sus Christ_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c' 
        { \clef "bass" \key bes \major \cadenzaOn
          a2 bes c d4 c2 (bes4) a2 a a g a4 bes c d c2 (bes4) a2
          d2 d4 f (ees) d c ( d ees) d 
          \override BalloonText.annotation-balloon = ##f 
          <c \balloonText #'(2 . 3)\markup { "" } >2
          bes
        } \cIt 
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        {
          d2 d-> d d4 d2. d2 \resp d2 d d d4 d-> d d d2. d2
          g2 g4 g2-> g4 g2. d2 d4 g2\fermata
        } \cIb 
      }
   >>
>>