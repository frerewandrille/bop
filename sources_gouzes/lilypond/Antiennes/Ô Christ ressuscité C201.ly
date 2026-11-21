\version "2.24.0"
%\include "TonsDef.ly"


\transpose fis e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo 2. = 58
          fis4 g2 g8 ([a]) b2-> c4 a2\fermata\breathe%\allowBreak
          a4 b-> b b g2 \allowBreak a4 b-> g a c2 (b4) a2\fermata\breathe\allowBreak
          a4^\markup{\dynamic p\italic"élargir"} e2. e4-> e fis g-> e g fis2.\fermata fis \fermata\bar "|."
        } \tonVIIaf %\tonVIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 d2 d4 g2 g4 fis2 fis4 fis fis fis e2 fis4 g e e e2. fis2
          fis4 e2. e4 e e e b b d2. d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Ô Christ res -- sus -- ci -- té, tu es le plus beau des en -- fants des
      hom -- mes_! La grâce est ré -- pan -- due sur tes lè -- vres.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          a4 b2 b8 ([c]) d2 e4 d2 d4 dis dis dis b2 d4 d e e c2. d2
          d4 c2. c4 c c b g g a2. a
        } \tonVIIah %\tonVIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d4 g2 g4 g2-> c,4 d2\fermata\breathe
          d4 b-> b b e2 d4 g-> c b a2. <d, d'>2\fermata\breathe
          <d d'>4 a'2. a4-> a a e-> g e d2.\fermata d\fermata
        }
      }
   >>
>>