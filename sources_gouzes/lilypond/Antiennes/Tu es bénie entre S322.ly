\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 63
         d2 bes4 a g2 bes4 c d2 ees4 c d2 d \resp
         bes2 c4 d bes2 a g\resp
         d'2 bes4 (a) g2 bes4 c d d ees c d2 d\resp
         bes2 c4 d bes2 a g\resp a2 bes4 c d2 c4 d bes (a8 [g] a2) g\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2 d4 c ees2 f4 ees d2 c4 g' f2 f g ees4 d ees2 g4 (f) d2
         f2 d4 (c) ees2 f4 ees d d c4 g' f2 f g ees4 d ees2 g4 (f) d2
         f2 d4 g f2 g4 f ees (c g' f) d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu es bé -- nie en -- tre tou -- tes les fem -- mes, 
     Mè -- re de mon Sei -- gneur,
     et bé -- ni soit le fruit de tes en -- trail -- les, 
     ô fil -- le d’Is -- ra -- ël,
     Al -- le -- lu -- ia, al -- le -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 g4 a bes2 bes4 g bes2 g4 g a2 a g g4 bes g2 g4 (a) bes2
          a2 g4 (a) bes2 bes4 g bes bes g4 g a2 a g g4 bes g2 g4 (a) bes2
          d2 bes4 g a2 g4 g g2 (a) bes
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 g4 f ees2 d4 c bes2 c4 ees d2 d\resp
          ees2 c4 g c2 ees4 (d) g,2\resp
          d'2 g4 (f) ees2 d4 c bes bes c4 ees d2 d\resp
          ees2 c4 g c2 ees4 (d) g,2\resp
          d'2 g4 ees d2 ees4 d c (ees d2) <g, g'>\fermata
        } \tonIIah
      }
   >>
>>