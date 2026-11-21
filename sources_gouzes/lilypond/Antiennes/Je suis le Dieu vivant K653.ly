\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

%\transpose bes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2. = 50
          bes4^> bes bes bes2 bes4 g2.\resp 
          bes4^> bes bes c2 c4 d^> d d c2. \resp c2 c4 bes2. (c) c1.\fermata
          \bar "|."
        }\cadenzaOn \transpose a g \tonVIIef
        %\transpose b a \tonIIIcf
        %\transpose a g \tonVIIff
        %\transpose g bes \tonIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          g4 g g f2 f4 g2. g4 g g g2 g4 bes bes bes g2. g2 g4 g1. g
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Je suis le Dieu vi -- vant_: Je ne veux pas la mort du pé -- cheur,
     mais qu’il vi -- ve_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d d2 d4 e2. d4 d d e2 e4 f f f e2. e2 e4 d2. (e) e1.
        }\cadenzaOn \transpose a g \tonVIIeh
        %\transpose b a \tonIIIch
        %\transpose a g \tonVIIfh
        %\transpose g bes \tonIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g4_> g g bes2 bes4 c2.\resp g4_> g g c2 c4 bes_> bes bes c2.\resp 
          c2 c4 g2. (c) c1.\fermata
        }
      }
   >>
>>