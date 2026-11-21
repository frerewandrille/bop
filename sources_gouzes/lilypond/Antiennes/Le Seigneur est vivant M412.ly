\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose f c
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8 a ([c]) c4 (a8 [g] c [d]) d4\fermata\bar"|"
         d8 [f] e ([d]) c [d] a4.\fermata\resp
         d8 d [c] c [d] a4.*2/3\fermata\resp s8
         g8 g ([a]) f4 f\fermata
         \bar"|."
       } \tonVbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f8 f ([g]) a ([g] f [e] g4) a
         a8 [a] a4 g8 [g] f4. a8 a [a] g [g] f4.
         e8 e4 d c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Le Sei -- gneur est vi -- vant. 
     Il a vain -- cu la mort_!
     Al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          f8 e ([d]) e4 (d e) f
          d8 [d] e ([f]) e [d] c4. c8 d [d] e [e] d4.
          d8 d4 c8 ([b]) a4
        } \tonVbh
      }
      \new Voice = "basse" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c
        { 
          f8 f4 a8 ([c] d4 a) <d, d'>\fermata
          f8 [a] c ([d]) a [a] f4.\fermata\resp
          f8 f [f] a [a] d4\fermata
          \override BreathingSign.Y-offset = #2 \resp
          \override BalloonText.annotation-balloon = ##f 
          <c \balloonText #'(1.5 . 3)\markup { "" } >
          b? a8 ([g]) f4\fermata
        } 
      }
   >>
>>