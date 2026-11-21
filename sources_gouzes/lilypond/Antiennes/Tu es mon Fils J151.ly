\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff 
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn \tempo "Calme" 2 = 60
          \revert Staff.TimeSignature.style
          a2 a4 f g1 g2 bes a1\fermata \breathe \allowBreak
          c2. c4 d2 (c a bes) a1\fermata \breathe \allowBreak
          a4 a g2. \allowBreak g4 bes2 bes4 bes g2. \allowBreak%\breathe \allowBreak
          g4 c c a a d d c2. \breathe \allowBreak
          a4 bes2 bes4 (a) g1\fermata \bar "|."
        }\transpose a g \tonVIIbf
        %\tonIVdf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { \cadenzaOn
          f2 f4 d d1 d4 (c) d (e) f1
          a2. g4 f (g a2 f4 e f g) c,1
          f4 f e2. e4 g2 g4 g e2. e4 e e f f f g a2.
          f4 g2 g4 (f) e1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Tu2 es4 mon Fils1 bien-2 ai -- mé,1 al2. -- lé4 -- lu\breve -- ia_!1
     De4 mon sein2. je4 t’ai2 en4 -- gen -- dré2.
     a4 -- vant l’é -- toi -- le du ma -- tin,2. al4 -- lé2 -- lu -- ia_!1
   }
   \new Staff
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c' 
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
          \revert Staff.TimeSignature.style
          d2 d4 a bes1 bes2 bes c1 c2 
          \override BalloonText.annotation-balloon = ##f 
          <f \balloonText #'(1 . 2)\markup { "" } >
          d (e d2. e4) f1
          c4 c c2. c4 d2 d4 d c2. c4 c c d d d e f2. f4 d2 d e1
        }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          d2 d4 d g1 g2 g f1\fermata \breathe f2 a bes (a d g,) f1\fermata \breathe
          f4 f c2. c4 g'2 g4 g c,2. %\breathe 
          c4 a' a d, d bes' bes f2. \breathe
          d4 g2 g c,1\fermata 
        }\transpose a g \tonVIIbh
        %\tonIVdh
      }
   >>
>>