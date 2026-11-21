\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 126
         g4 f8 [g] a4 a bes bes a2\resp g4 f8 [g] a4 g f e d2\resp
         g4 f8 [g] a4 a bes bes a2\resp d4 d8 [c] d4 c bes a g2         
         \bar"|."
       } \tonIIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d8 [d] f4 f f f f2 d4 d8 [d] f4 d d cis d2
         d4 d8 [d] f4 f f f f2 bes4 bes8 [a] bes4 a g fis d2         
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ré -- jou -- is_- toi, Jé -- ru -- sa -- lem_:_ Voi -- ci ton Roi qui vient vers toi_!
     Dan -- se de joie et ne crains pas_:_ Sur toi bien -- tôt vient le sa -- lut_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 a8 [bes] c4 c d d c2 bes4 a8 [bes] c4 bes a a a2
          bes4 a8 [bes] c4 c d d c2 f4 f8 [f] f4 f d c bes2
        } \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 d8 [g] f4 f bes, d f2\resp g4 d8 [g] f4 g d a d2\resp
          g4 d8 [g] f4 f bes, d f2\resp bes4 bes8 [f] bes4 f g d g2
        } 
      }
   >>
>>