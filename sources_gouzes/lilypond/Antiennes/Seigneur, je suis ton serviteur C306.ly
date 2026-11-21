\version "2.24.0"

%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 2/2 \cadenzaOn \tempo "Calme et large" 2 = 54
          bes2 g2. bes4 c^> c d^> d bes2.\fermata \breathe \allowBreak
          bes4 c c bes bes a! a bes2 g4 \allowBreak g^> f f g2 ees\fermata \bar "|."
        }
        \tonVdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          g2 ees2. g4 aes aes f f g2. g4 aes aes f f f f f2 ees4 ees c d ees2 bes
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      Sei2 -- gneur,2. je4 suis ton ser -- vi -- teur.2.
      Je4 viens t’of -- frir le sa -- cri -- fi2 -- ce4 d’ac -- tion de grâ2 -- ce.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 2/2 \cadenzaOn
          ees2 bes2. ees4 ees ees d d ees2. 
          ees4 ees ees d d c c d2 bes4 bes a! a bes2 g
        }
        \tonVdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          ees2 ees2. ees4 aes_> aes bes_> bes ees,2.\fermata \breathe
          ees4 aes! aes bes bes f f d2 ees4 ees_> f f ees2 ees\fermata
        }
      }
   >>
>>