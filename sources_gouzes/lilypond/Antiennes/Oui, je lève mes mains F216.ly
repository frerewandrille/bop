\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Dynamics 
   {
     a2 a4 c c c a2 a4 d2 d4 c2 c4
     d2^\> d4 c2 c4 bes (c) bes a2.\!
     \bar"|."
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2 = 66
         a2 a4 c-> c c a2 a4 d2 d4 c2 c4\resp
         d2-> d4 c2 c4 bes->^\markup\italic"rall." (c) bes a2.\fermata
         \bar"|."
       } \tonVIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2 f4 e e e f2 f4 f2 g4 a2 a4 f2 g4 a2 a4 g2 g4 f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Oui, je lè -- ve les mains vers ta Pa -- ro -- le, 
     car je l’ai beau -- coup ai -- mée.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 c c c d2 d4 d2 d4 e2 e4 d2 d4 e2 e4 d (e) d c2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 a-> a a d,2 d4 bes'2 bes4 a2 a4\resp
          bes2-> bes4 a2 a4 bes2 bes4 f2.\fermata
        } \tonVIhh
      }
   >>
>>