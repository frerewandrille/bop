\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 4/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
          \partial 2 a2\< f4 g\! a2\> f2.\!  a4 
          d\< d d\! c2. f,2\> g4 a2.\!
          a4\< a a\! g2 g4\> a2 a4\! f2. e 
          e4\< f f g\! g 
          a2 bes4 a2\> g4 a2\!
          a4 f f f g g g a2 a4 f2 g4 a2
          a4 d d d c2 c4 f,2
          f4 f2 g4 a2.          
          \bar "|."
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "Large" 2. = 69 %"environ"
          \partial 2 a2 f4 g a2 f2. \resp a4 \time 3/4
          d d d c2. f,2 g4 a2.\fermata
          a4 a a g2 g4 a2 a4 f2. \time 4/4 e \resp
          e4 f f^\markup\italic"presser un peu" g g \time 3/4
          a2 bes4 a2^\markup\italic"rall." g4 a2\fermata\resp
          a4 f f f g g g a2 a4 f2 g4 a2\fermata\resp
          a4 d d d c2 c4 f,2^\markup\italic"rit."\resp
          f4\fermata f2\fermata g4\fermata a2.\fermata          
          \bar "|."
          \cadenzaOn a\breve bes8 g4\noBreak\bar"|" 
          g\breve a f4 \noBreak\bar"||" 
          a\breve g4\bar"|."
        }
      }
      \new Voice = "alto" %\with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        {
          f2 d4 e f2 c2. f4 f f g a2. d,2 e4 f2.
          f4 f f e2 e4 e2 e4 d2. cis cis4 d d e e f2 f4 f2 e4 e2
          e4 d d d e e e e2 e4 d2 e4 e2 f4 f f g a2 a4 f2 f4 f2 e4 f2.
          f\breve f8 e4 e\breve e d4 f\breve e4
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Dans ce mys -- tè -- re, 
     le Christ va s’of -- frir  par -- mi nous. 
     Dé -- po -- sons tous sou -- cis du mon -- de.
     Al -- lons à la ren -- con -- tre du Sei -- gneur
     a -- vec les puis -- san -- ces du ciel et tous les saints.
     Chan -- tons le Sei -- gneur vi -- vant et trois fois saint_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \armure
          d2 a4 c c2 a2. c4 d d d e2 (c4) d2 d4 c2.
          c4 c c c2 c4 a2 a4 a2. a a4 a a c c c2 d4 c2 c4 cis2
          cis4 a a a c! c c cis2 cis4 a2 c!4 cis2
          d4 d d d e2 e4 d2 d4 d2 d4 c2.
        \cadenzaOn c\breve d8 c4 c\breve cis a4 c\breve c4
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          d2 d4 c f2 f2. \resp
          f4 bes bes bes a2. bes2 bes4 f2.\fermata
          f4 f f c2 c4 cis2 cis4 d2. a\resp
          a4 d d c c f2 f4 f2 c4 a2\fermata\resp
          a4 d d d c c c a2 a4 d2 c4 a2\fermata\resp
          d4 bes' bes bes a2 a4 bes2\resp 
          bes4\fermata bes2\fermata bes4\fermata f2.\fermata
          f\breve bes,8 c4 c\breve a d4 f\breve c4
        }
      }
   >>
>>