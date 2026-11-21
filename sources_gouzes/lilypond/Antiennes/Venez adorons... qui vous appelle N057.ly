\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

global = {\key g \major \time 2/4}

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn \tempo "Calme"% 2 = 52
          g4 g a b a-> (b8 [c]) b4. a8 g4 \breathe\allowBreak
          g fis-> g a4.-> a8 g4-> fis g2\fermata\breathe\allowBreak
          g2 a4 b a-> b8 ([c]) b4.-> a8 g4. \breathe\allowBreak
          a8 b4 (a8 [g]) a4.-> (g8) g2\fermata\bar "|."
        } \transpose a b \tonVIgf % Pas de ton dans l’original
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver"
                                  \override BalloonText.annotation-balloon = ##f }
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 d d g g2 g4 
          <fis \balloonText #'(0.75 . -2)\markup { "" } >
          d d d d d4. d8 d4 d d2
          d d4 g g g g 
          <fis \balloonText #'(0.75 . -2)\markup { "" } >
          d4. d8 g4 (e) fis4. (d8) d2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ve -- nez, a -- do -- rons le Sei -- gneur qui vous ap -- pel -- le ses a -- mis_:
     Il a don -- né sa vie pour vous_! Al -- le -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \global \cadenzaOn
          b4 b c d c (d8 [e]) d4. c8 b4 b a b c4. c8 b4 a b2
          b c4 d c d8 ([e]) d4. c8 d4. c8 d4 (c8 [b]) c4. (b8) b2
        } \transpose a b \tonVIgh
      }
      \new Voice = "basse" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4 g g g g2-> g4 
          <d \balloonText #'(0.75 . 5)\markup { "" } >
          g\breathe 
          g d-> g fis4.-> fis8 g4-> d g2\fermata\breathe
          g g4 g g-> g g-> 
          <d \balloonText #'(0.75 . 5)\markup { "" } >
          g4. \breathe
          g8 g2 d4.-> (g8) g2\fermata 
        }
      }
   >>
>>