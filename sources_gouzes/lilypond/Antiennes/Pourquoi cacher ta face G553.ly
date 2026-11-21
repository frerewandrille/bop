\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 72
         d4 d-> e g-> a a2 2. \resp a4 a-> g4 a2. \allowBreak b4 g-> a a2 a\resp
         e4-> a fis2. g4 e-> d e2 e \bar"|"
         e2 e4 d c2\resp c4-> d e2 g e\fermata
         \bar"|."
       } \tonIVaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d e g a a2 2. e4 e e4 e2. g4 e e e2 e c4 d d2. b4 c4 b g (a) b2
         b2 c4 b a2 a4 b c2 b cis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pour -- quoi ca -- cher ta fa -- ce_? Ré -- veil -- le_- toi_!
     Viens à notre ai -- de_! N’ou -- blie pas no -- tre mi -- sè -- re_!
     Viens nous sau -- ver_!_ Viens, Sei -- gneur Jé -- sus_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d4 d e g a a2 2. c4 c d4 c2. d4 d d c2 c a4 a b2. g4 a fis e (fis) g2
          g a4 fis e2 e4 fis a2 g a
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d-> e g-> a a2 2. \resp a4 a-> b4 a2. g4 b-> b a2 a\resp
          a4-> fis d2. e4 a,-> b c2 b
          b a4 b c2\resp c4-> b a2 e' <a, a'>\fermata
        } 
      }
   >>
>>