\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 88
          e2 gis4 gis a2. g4 c2-> (b4) a gis2->^\markup{\italic élargir} a gis!2.\fermata\resp
          \tempo "Agressif" a8 [a] b2 c-> a4 a gis2\fermata
          \bar"|."
        } \tonIVbf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { 
          b2 e4 e f2. e4 g2. e4 e2. 
           \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(-2 . -2)\markup { "" } >4
          e2. e8 [e] g2 g f4 f e2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Des é -- tran -- gers se dre -- sent con -- tre moi_! 
      Des vio -- lents cher -- chent ma mort_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          gis2 b4 b d2. b4 e2 (d4) c b2 a b2. cis8 [cis] d2 e c4 d b2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e2 e4 e d2. e4 c2-> (g'4) a e2-> f e2.\fermata\resp
          a8 [a] g2 c,-> f4 d e2\fermata
        } \tonIVbh
      }
   >>
>>