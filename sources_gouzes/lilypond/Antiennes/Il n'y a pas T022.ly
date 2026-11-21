\version "2.24.0"

%\include "TonsDef.ly"

\new ChoirStaff
<< \new Dynamics 
   {
     fis2 d4 e fis2 fis4 fis g (fis) e2 fis1
     fis2 fis4 fis b b a2.^\> fis4 g2fis fis1\!  
   }
   \new Staff \with {\remove Time_signature_engraver } 
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key d \major \cadenzaOn \tempo "Très calme" 2 = 54
          fis2 d4 e fis2 fis4 fis g (fis) e2 fis1\fermata \breathe \allowBreak 
          fis2 fis4 fis b b a2. \allowBreak fis4 g2^\markup{\italic rall.} fis fis1\fermata \bar "|."
        }
        \transpose a b \tonIVcf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { d2 b4 b d2 d4 d e (d) d2 cis1 d2 d4 d d e fis2. dis4 e2 cis dis!1
        } 
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Il2 n’y4 a pas2 de4 plus grand2 a -- mour1 que2 de4 don -- ner sa vie2. pour4 ses2 a -- mis.1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key d \major \cadenzaOn
          b2 fis4 fis b2 b4 b b2 b ais1 b2 b4 b b b cis2. b4 b2 ais b1
        }
        \transpose a b \tonIVch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { b2 b4 cis d2 d4 d e (fis) g2 fis1\fermata \breathe
          b2 a4 a g g fis2. b,4 e2 fis b,1\fermata
        }
      }
   >>
>>