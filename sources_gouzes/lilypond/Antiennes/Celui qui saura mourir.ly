\version "2.24.0"
%\include "TonsDef.ly"

\transpose d b,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn
          \partial4 d d-> c bes a2 g4 g2 f4 g2. \allowBreak
          g4 (a) bes g2 g4 g2 f4 g2.
          \bar "|."
        }\cadenzaOn \tonIIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 f4 f f g f2 ees4 ees2 d4 d2. d2 d4 ees (d) c d2 d4 d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Ce -- lui qui sau -- ra mou -- rir en tout trou -- ve -- ra la vie en tout.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4\cadenzaOn
          \partial4 d4 d d d d  (c) bes c (bes) a bes2. bes2 bes4 bes2 g4 a2 a4 bes2.
        }\cadenzaOn \tonIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial4 bes4 bes-> a g d2 ees4 c2 d4 g2. g4 (f) f ees2 ees4 d2 d4 g2.
        }
      }
   >>
>>