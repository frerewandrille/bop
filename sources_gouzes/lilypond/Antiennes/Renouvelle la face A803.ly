\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose bes a
\new ChoirStaff
<<\new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large et marqué" 2 = 100
         bes2 bes bes4 (a) bes-> c bes2 bes4 (c) d2. d4 c2 bes a (g) a\resp
         a bes4 a g2. bes4 a2 g fis2.\fermata\resp
         g4 a2 a g4-> fis! g-> a bes2. bes4 c2 (bes) a1 (g) a\fermata
         \bar"|."
       } \transpose c bes, \tonVIIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2 f f f4 f f2 f bes2. bes4 f2 f f (d4 e) f2
         f f4 f d2. d4 d2 d d2. d4 d2 d d4 d d d d2.
         g4 g2 (d) d1. (e!2) f1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Re -- nou -- vel -- le, Sei -- gneur, la fa -- ce de la ter -- re
     et com -- ble_- la de ton a -- mour, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d d4 (c) d ees d2 d4 (ees) f2. f4 ees2 d c (bes) c
          c d4 c bes2. d4 c2 bes a2. bes4 c2 c bes4 a bes c d2.
          d4 ees2 (d) c1 (bes) c
        } \transpose c bes, \tonVIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes2 bes bes4 (f) bes-> a bes2 bes bes2. bes4 f2 f f (g) f\resp
          f f4 f g2. g4 d2 d d2.\fermata\resp d4 d2 d d4-> d d-> d g2.
          g4 g1 g~ g f\fermata
        } 
      }
   >>
>>