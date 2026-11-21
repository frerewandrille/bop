\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Très calme" 2. = 42
          a2 bes4 g2 (a4) f2.\resp 
          f2^\< f4 e2^\> f4 g2.\!\resp a2 f4 g g g a2.\fermata
          \bar"|."
        } \tonVIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f4 e2. d d2 d4 cis2 d4 e2. e2 d4 d d e f2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ô mon Pè -- re, garde en ton a -- mour
      ceux que tu m’as don -- nés_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 d4 c2 (a4) a2. a2 a4 a2 a4 c2. cis2 a4 bes bes bes c2.
        } \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 bes,4 c2 (cis4) d2.\resp d2 d4 a2 d4 c2.\resp
          a2 d4 g g g f2.\fermata
        } 
      }
   >>
>>