\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif et décidé"
         gis4 4 (fis) gis2 8 [8] a2.-> 4-> 4 gis! a2.->\bar"|" 
         b4-> b (c) b2-> \resp b8 [b] a2.-> gis4-> a b b2.\fermata
         \bar"|."
       } \tonIVaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e4 e (dis) e2 e8 [e] e2. e4 e e e2. g4 2 2 8 [8] e2. 4 4 g gis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ho -- san -- na_! À Jé -- sus, fils de Da -- vid_!
     Ho -- san -- na_! À Jé -- sus, fils de Da -- vid_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 2 2 8 [8] c2. 4 4 b c2. d4 d (e) d2 8 [d] c2. b4 c d e2.
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> e (b) e2->\resp 8 [8] a2.-> a4-> a e a2.->
          g4-> g (c,) g'2-> \resp g8 [g] a2.-> e4-> a g e2.\fermata
        } 
      }
   >>
>>