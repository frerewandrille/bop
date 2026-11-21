\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

\new ChoirStaff
<< \new Dynamics { 
  e4^\< e f2 g4\! a2^\> gis4 a2 \!
  b4^\< c2\! b4^\> a2 a4 gis!2. \!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key c \major \time 3/4 \cadenzaOn \tempo 4 = 112
          e4 e f2 g4 a2 gis4 a2\fermata \breathe\allowBreak
          b4 c2 b4 a2 a4 gis!2.\fermata 
          \bar "|."
        }\tonIVmf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          cis4 cis d2 e4 e2 e4 e2 e4 e2 e4 e2 e4 e2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { 
     Je suis pauvre et dé -- lais -- sé_: Sei -- gneur, ne
     tar -- de pas_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4 \cadenzaOn
          a4 a a2 c!4 c 
          \override BalloonText.annotation-balloon = ##f 
          < b \balloonText #'(1 . 2)\markup { "" } >2
          c gis4 a2 d4 c2 c4 b2.
        }\tonIVmh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          a4 a d2 c4 a e'2 a,\fermata \breathe e'4 a,2 gis4 a2 a4 e'2.\fermata
        }
      }
   >>
>>