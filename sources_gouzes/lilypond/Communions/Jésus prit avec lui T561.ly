\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a fis
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      {  \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 48
          r4 \voiceOne a a c-> a c d-> c d c-> (a) \allowBreak c d-> (a) d c2. c\bar"|"
          \oneVoice r4 \voiceOne a4 a \allowBreak c-> (a) c d-> (a) d 
          c-> f,^\markup\italic"rall." g a2.\fermata
          \bar"|."
        } \tonVIkf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          s4 f f f f f e f e d (e) d c d e f (e f) e2.
          s4 f f f2 f4 e (f) e d e d f2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Jé -- sus prit a -- vec lui Pierre et Jacques et Jean son frè -- re,
      et il fut trans -- fi -- gu -- ré de -- vant eux.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          r4 f e d e d c d c bes (c) bes a (bes) c d( c d) c2.
          r4 f e d (e) d c (d) c bes c bes c2.
        } \tonVIkh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2. a bes a2.*2/3 s4 g2. a1. a2. d a g f\fermata
        } 
      }
   >>
   \new Lyrics \lyricsto "basse"
   {
      Lu -- men de lu -- mi -- ne, De -- us de De -- o.
   }
>>