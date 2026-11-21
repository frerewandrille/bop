\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 3/4 }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<< \new Staff 
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure 
         \partial 4 g4 a2 8 8 g2 a4 b2 4 g2 \breathe 
         b8 8 2 8 8 c4 b2-> a4 b2~ 4\breathe \silN
         g4 2 e8 fis g4 4 fis~-> 4 g2\fermata
         \bar"|."
       } \cadenzaOn \transpose a b \tonVIjf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 fis2 8 8 d2 fis4 g2 4 d2 g8 8 2 8 8 4 2 fis4 g2~ 4 s
         d4 2 c8 8 d4 4 d~ d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Christ est res -- sus -- ci -- té des morts. 
     Par sa mort, il a vain -- cu la mort.
     Aux morts, il a don -- né la vie_!
   }
   \new Staff 
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          b4 d2 8 8 b2 d4 2 4 b2 d8 8 2 8 8 c4 d2 4 2~ d4 \silN
          b4 2 g8 a b4 a2 
          <a \balloonText #'(-2.5 . 2.5)\markup { "" } >4 b2
        } \cadenzaOn \transpose a b \tonVIjh
      }
      \new Voice = "basse" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      { \voiceTwo \relative c'
        { 
          g4 d2 8 8 g2 d4 g2 4 2 \breathe 8 8 2 8 8 c4 d 
          <d, \balloonText #'(2.5 . 4)\markup { "" } >~ d g2~ 4 \breathe
          s g4 2 c,8 a g4 d'2 4 g2\fermata
        } 
      }
   >>
>>