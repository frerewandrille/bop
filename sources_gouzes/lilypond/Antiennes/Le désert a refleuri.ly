\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Doux et balancé"% 2 = 52
          g4 a c c a c b2 g4 g a2. a4 b a a2\resp
          a4 a c2 a4 c b2\resp a4 c a2 g4 g a2\fermata
          \bar"|."
        } \tonIIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e e fis? e g2 g4 g e2. e4 fis e fis2
          fis4 fis e2 fis4 e g2 e4 fis e2 e4 e e2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le dé -- sert a re -- fleu -- ri, lors -- que Jean, l’a -- mi de Dieu,
      est ve -- nu pré -- pa -- rer les che -- mins du Sei -- gneur.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c c d c d2 d4 d c2. c4 d c d2
          d4 d c2 d4 c d2 c4 d c2 b4 b a2
        } \tonIIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          c4 b a a d, a' g2 b4 b a2. a4 d, a' <d, a'>2\resp
          d4 d a'2 d,4 a' g2\resp a4 d, a'2 e4 e <a, e'>2\fermata
        } 
      }
   >>
>>