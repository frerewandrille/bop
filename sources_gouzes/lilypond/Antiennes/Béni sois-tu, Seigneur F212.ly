\version "2.24.0"
%\include "TonsDef.ly"

rall = #(make-dynamic-script 
         (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0
armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Dynamics { 
  bes2 c4 c ees2 d4 (c) bes2 c d
  d2 d4 d b2 b4 \agauche c4\rall^\> a2 bes a\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 76
         bes2 c4 c ees2 d4 (c) bes2 c d\fermata\resp
         d2 d4 d b2 b4\resp c4 a2 bes a\fermata
         \bar"|."
       } \transpose g bes \tonIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 f4 f g2 f d g fis 
         fis! fis4 fis g2 g4 g fis!2 d4 (e) fis!2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Bé -- ni sois_- tu, Sei -- gneur mon Dieu_:
     En ta Pa -- ro -- le, j’ai mis ma joie_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 a4 a bes2 bes4 (a) bes2 g a 
          d2 d4 d d2 d4 e d2 d d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 f4 f ees2 bes4 (f') g2 ees d\fermata\resp
          d2 d4 d g2 g4\resp c, d2 g d\fermata
        } \transpose g bes \tonIIch
      }
   >>
>>