\version "2.24.0"
%\include "TonsDef.ly"


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo "Paisible" 2. = 50
          a2. g2.~g4 bes\rest g c2^> c4 bes2 bes4 a2.\breathe\allowBreak 
          c4^> a bes c2 c4 bes2 bes4 a2. g\bar"|."
        }\transpose g f \tonVIbf
        %\transpose b a \tonVIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2. e~e4 s e d2 d4 e2 e4 f2. f4 f f f2 f4 e2 e4 f2. e
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, re -- lè -- ve tes en -- fants, 
      af -- fer -- mis_- les de -- vant ta fa -- ce_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          c2. c~c4 s c bes2 bes4 c2 c4 c2. c4 c c c2 c4 c2 c4 c2 (b4) c2.
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2. c~ c4 d\rest c g'2_> g4 g2 g4 f2.\breathe
          a4_> f g a2 a4 g2 g4 f2. c
        }\transpose g f \tonVIbh
        %\transpose b a \tonVIeh
      }
   >>
>>