\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn \tempo "Calme, mais allant" 2 = 60
          bes4 bes bes a g g a2 a4 c c2 c4 c bes2 bes4->\breathe
          bes g-> g a2.\fermata\bar "|"
          \tempo "Calme" a4 a-> a a-> a g2. g4 g-> g a-> a f-> f g2 g\bar "|."
        }\tonIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          f4 f f f d e! f2 f4 a g2 g4 g g2 g4 g d e f2.
          f4 f f f f e2. e4 e e e e d d d2 d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Le Sei -- gneur a en -- vo -- yé un sau -- veur à son peu -- ple, al -- lé -- lu -- ia_!
      Il donne à son É -- gli -- se les na -- tions en hé -- ri -- ta -- ge_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
          d4 d d c bes bes c2 c4 f e!2 e4 e d2 d4 d bes bes c2.
          c4 c c c c c2. c4 c c c c a a bes2 bes
        }\tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          bes4 bes bes f g g f2 f4 f c2 c4 c g'2 g4-> \breathe g g-> g f2.\fermata
          f4 f-> f  f-> f c2. c4 c-> c c-> c d-> d g2 g
        }
      }
   >>
>>