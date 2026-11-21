\version "2.24.0"
%\include "TonsDef.ly"


\transpose d b,
\new ChoirStaff
<< \new Dynamics 
   {
     d2*1/2^\< s4^\> d2.\! ees4^\< d\> (c) c2\!
     c2*1/2^\< s4^\> c2.\! c4^\< c\> (bes) bes2\!
     bes2 a4 g a2.\allowBreak a4 c2 bes a1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn \tempo  2 = 50
          d2*1/2 s4 d2.\fermata ees4 d (c) c2\fermata\breathe\allowBreak
          c2*1/2 s4 c2.\fermata c4 c (bes) bes2\fermata\breathe\allowBreak
          bes2 a4 g a2.\allowBreak a4 c2 bes a1\fermata
          \bar"|."
        }\transpose g bes \tonIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 ees2. ees4 ees2 d d c2. c4 c (cis) cis2 cis! cis4 cis d2. d4 d2 d4 (e) fis1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur, é -- cou -- te_! Sei -- gneur, par -- don -- ne_! 
     Veil -- le, Sei -- gneur, et sau -- ve_- nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          bes2 g2. g4 a2 a a g2. g4 g2 g g g4 g fis2. fis4 a2 bes4 (c!) d1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 ees2.\fermata c4 c2 d\fermata\breathe 
          d ees2.\fermata ees4 ees2 ees\fermata\breathe
          ees ees4 ees d2. d4 fis!2 g d1\fermata
        }\transpose g bes \tonIIch
      }
   >>
>>