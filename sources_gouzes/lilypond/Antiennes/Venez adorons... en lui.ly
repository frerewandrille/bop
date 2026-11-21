\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo "Calme, mais vivant"% 2 = 52
          g4 g8-> ([fis]) g[a] b4 (c) b4. a8 g4\fermata\breathe\allowBreak
          b8 ([c]) d4 d c8 ([b]) c4 b2\fermata \bar "|" d4 c8 [d] e4 e d4. c8 b4\breathe\allowBreak
          d c2 c4 b2 g4 a2\fermata\bar "|."
        } \tonVIIaf % Pas de ton dans l’original
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" 
                                  \override BalloonText.annotation-balloon = ##f }
      { \voiceTwo \relative c'
        { 
          d4 d d8 [d] g2 g4 
          
          <fis \balloonText #'(1.5 . -2)\markup { "" } >
          d g g g g fis g2
          g4 g8 [g] g4 g g 
          <fis \balloonText #'(1.5 . -2)\markup { "" } >
          g g e2 fis4 g2 e4 fis2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ve -- nez, a -- do -- rons le Sei -- gneur. En lui, cri -- ons de joie_!
     Car le Roy -- aume est ré -- vé -- lé aux humbles et aux pe -- tits.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          b4 b8 ([a]) b [c] d4 (e) d 
          <c \balloonText #'(1.5 . 2)\markup { "" } >
          b d b b e d d2
          b4 a8 [b] c4 c b 
          <a \balloonText #'(1.5 . 2)\markup { "" } >
          g b c2 c4 d2 b4 d2
        }\tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g-> g8 [g] g4 (c,) d d g\fermata\breathe
          g8 ([a]) b4 b a a g2\fermata g4 g8 [g] c,4 c d d g\breathe g a2 a4 g2 g4 d2\fermata
        } 
      }
   >>
>>