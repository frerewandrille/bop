\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
barre = { \undo \omit Score.BarLine }
barress = { \omit Score.BarLine }

\transpose b fis
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo 2. = 66
          \barress
          \partial4 b4 d2 e4 d2 b4 d2 e4 d2 b4 d-> b g a2\fermata\resp
          b4 d-> d c b-> a b d-> d c b2 g4\resp
          a-> a c b2 g4 a2 a4 \noBreak g2.\fermata
          \barre
          \bar "|."
        }\cadenzaOn \transpose a b \tonVIcf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c''
        {
          \partial4 g4 b2 g4 b8 (a g4) g g2 g4 b8 (a g4) g g g e fis8 (e fis4)
          g g g a g e8 (fis) g4 g g a b8 (a g4) d
          fis8 (e) d4 d d2 d4 fis8 (e) 
          \override BalloonText.annotation-balloon = ##f 
          <fis \balloonText #'(1 . -2)\markup { "" } >2
          g2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Le jour où Dieu nous a ma -- ni -- fes -- té son a -- mour,
      il nous a sau -- vés par le bain du bap -- tê -- me
      qui re -- nou -- vel -- le dans l’Es -- prit.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \partial4 d4 b8 (c d4) c d2 d4 b8 (c d4) c d2 d4 b8 (c) d4 b d2
          d4 b8 (c) d4 e d e d b8 (c) d4 e d2 b4
          d a a b8 (c d4) b a2 a4 b2.
        }\cadenzaOn \transpose a b \tonVIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial4 g4 g8 (a b4) c g2 g4 g8 (a b4) c g2 g4 g8 (a) b4 e, <d d'>2\fermata\resp
          g4 g8 (a) b4 c g-> c g g8 (a) b4 c g2 g4\resp
          d-> fis d g8 (a b4) b d,2 d4 g2\fermata
        }
      }
   >>
>>