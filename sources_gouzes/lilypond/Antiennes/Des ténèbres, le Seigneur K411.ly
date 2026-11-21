\version "2.24.0"
%\include "TonsDef.ly"
resp = { \breathe\allowBreak }

\transpose g g
\new ChoirStaff
<< \new Dynamics 
   {
     g2 g4 g2 (f4) g2.\resp 
     g2 bes4 g2. g4 g g g2 (f4) f2.\resp
     bes2^\< bes4 c c c d2.^\ff\!\resp
     d2^\> d4 c c c g2.^\pp\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn \tempo  2. = 48
          g2^\p g4 g2 (f4) g2.\resp 
          g2 bes4 g2. g4^> g g g2 (f4) f2.\resp
          bes2 bes4 c^> c c d2.\fermata\resp
          d2 d4 c^>^\markup{\italic rall.} c c g2.\fermata
          \bar "|."
        } \transpose c bes, \tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d2 d4 c (d2) d2. d2 f4 ees2. ees4 ees ees ees2 (d4) d2.
          f2 f4 ees ees ees g2. f2 f4 g g f d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Des té -- nè -- bres, le Sei -- gneur a fait son voi -- le_:
     Je t’in -- vo -- que, Sei -- gneur, for -- ce de mon sa -- lut_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c' 
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          bes2 bes4 g (a2) bes2. bes2 bes4 bes2. bes4 bes bes c2 (a4) a2.
          d2 d4 g, g g bes2. bes2 bes4 g g a bes2.
        } \transpose c bes, \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g2 g4 ees (d2) g2.\breathe g2 d4 ees2. ees4_> ees ees c2 (d4) d2.\breathe
          d2 d4 c_> c c g2.\fermata\breathe
          bes2 bes4 ees_> ees f g2.\fermata
        }
      }
   >>
>>