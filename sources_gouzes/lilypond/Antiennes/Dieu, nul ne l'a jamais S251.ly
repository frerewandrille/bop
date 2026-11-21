\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose d c
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 62
          d2.\espressivo d4 e-> d d-> b d2\fermata\resp
          b2. b4 g-> b b2 b4 a a2\fermata\resp
          b4 b b2 g4 b c2 b4 a b2\resp
          b4-> b b-> b g-> b b1 b2\fermata
          \bar"|."
        } \tonIIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2. g4 g g fis e fis2 e2. e4 g e g2 g4 e fis2
          g4 g g2 d4 g e2 e4 e dis2 dis!4 dis e e e fis g2 (fis4 e) fis2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Dieu, nul ne l’a ja -- mais vu,
      mais le Fils nous l’a ré -- vé -- lé_:
      Il a fait sa de -- meure en Ma -- rie, 
      et nous a -- vons vu sa gloi -- re_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2. b4 c b a g a2 g2. g4 b b d2 d4 cis d2
          d4 d d2 b4 g g2 g4 e fis2 fis4 fis g g b b b2. (cis!4) dis2
        } \tonIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2. g4 c,-> g' d-> e d2\fermata\resp
          e2. e4 e-> g g2 g4 a d,2\fermata\resp
          g4 g g2 g4 e c2 e4 c b2\resp
          b4-> b e-> e e-> dis e2 (dis!4 cis) b2\fermata
        } 
      }
   >>
>>