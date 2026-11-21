\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2. = 69
         g4---> a-- g-- a2.---> b4---> c-- b-- a2---> a4 g2.-> a-> a2->\resp
         d4 d2 c8 ([b]) a2.\fermata\resp
         d4-> d d c-> (b) c a2 b4 c2.-- b-- a\fermata
         \bar"|."
       } \transpose b a \tonVIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 fis e fis2. g4 g g fis2 fis4 e2 (fis8 [e]) fis2. fis2
         fis4 e2 e4 fis2. fis4 fis fis e (d) e fis (e) d e2 (fis4) g (fis e) fis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu as don -- né la dé -- li -- vran -- ce à ton Christ, al -- lé -- lu -- ia_!
     et à sa des -- cen -- dan -- ce à ja -- mais_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 d b d2. d4 e d d2 d4 b2. d d2 a4 c2 a4 a2. a4 a a a2 a4 d (c) b a2. d d
        } \transpose b a \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4---> d-- e-- d2.---> g4---> g-- g-- d2---> d4 e2.-> d-> d2->\resp
          d4 a2 c4 d2.\fermata\resp
          d4-> d d a'2-> a4 d,2 d4 a'2.-- g-- d\fermata
        } 
      }
   >>
>>