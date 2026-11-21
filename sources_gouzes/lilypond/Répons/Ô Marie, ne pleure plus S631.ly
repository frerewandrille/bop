\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g\minor \time 12/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \tempo 2. = 60
         g2. g4 (a bes) a2. g a a4 (bes c bes2) a4 g2. 
         d'2. c4 (d) ees d2 c4 bes2. c2 bes4 a2 a4 g1.
         d'2. bes4 (c d) c2. c bes g4 (a bes) a2. a
         g g4 (a) bes c2. c bes c4 (bes c) d1.
         g,2. g4 (a bes) a2. g a a4 (bes c bes2) a4 g2. 
         d'2. c4 (d) ees d2 c4 bes2. c2 bes4 a2 a4 g1.
         \bar"|."
       } \cadenzaOn\tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2. d fis g g fis (g2) 4 d2. d f!2 g4 a2 a4 g2. g2 g4 fis2 fis4 g1.\bar"||"
         f!2. f f f d g g fis g d2 d4 g2. f! d g fis1.\bar"||"
         bes,2. g' fis g g fis (g2) g4 g2. f! f2 f4 f2 4 g2. 2 4 fis2 4 g1.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Ma -- ri -- e, ne pleu -- re plus_:
     Ton fils, no -- tre Sei -- gneur, s’en -- dort dans la paix_;
     et son Pè -- re, dans la gloi -- re, ou -- vre les por -- tes de la vie_!
     Ô Ma -- ri -- e, ré -- jou -- is_- -- toi_: Jé -- sus res -- sus -- ci -- té a vain -- cu la mort_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { \repeat unfold 45 {\skip4} \set stanza = \markup\italic\small"le samedi saint :"
     le cru -- ci -- fié
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          bes2. d d bes ees d2.~ d2 c4 bes2. f' c2 bes4 d2 d4 2. ees2 d4 c2 4 bes1.
          bes2. bes bes a bes d d d g, bes2 4 2. a bes g a1.
          g2. d' d bes ees d2.~ d2 c4 bes2. bes a4 (bes) c bes2 a4 g2. ees'2 d4 c2 c4 bes1.
        }\cadenzaOn\tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          g2. bes d ees c d (g2) 4 2. bes a2 g4 fis2 4 g2. c,2 c4 d2 4 g1.
          bes,2. d f! f g bes, d d g f2 f4 ees2. f \tuplet 2/3 { g4 (f) } ees2. d1.
          ees2. bes d ees c d (g2) 4 2. bes f!2 4 bes,2 4 ees2. c2 c4 d2 d4 g1.
        } 
      }
   >>
>>