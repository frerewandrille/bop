\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose d cis
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2. = 76
          d4 c-> (d) ees d2\resp d4 c2 c4 d2 d4 bes2. f\bar"|"
          f2^\markup\italic"élargir" f4 g2-> g4 f-> g f f2.\fermata
          \bar"|."
        } \tonVIIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          bes4 bes2 bes4 bes2 bes4 g2 g4 a2 a4 f2. f f2 d4 c2 c4 d c c d2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Tes ser -- vi -- teurs con -- tem -- ple -- ront ta fa -- ce, 
      et ton nom se -- ra sur leur front.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          f4 ees (f) g f2 f4 ees2 ees4 f2 f4 d2. bes
          bes2 bes4 bes2 bes4 bes bes a bes2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 bes2 bes4 bes2\resp bes4 bes2 bes4 f2 f4 <bes, bes'>2. d
          d2 bes4 ees2-> ees4 d-> ees f bes,2.\fermata
        } \tonVIIIch
      }
   >>
>>