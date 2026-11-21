\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose d c
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Paisibe"% 2 = 52
          d4 d2 fis4 g a2 a4 a b b a g a2 a\resp
          b4 c b2 (a4 b) a2\bar"|"
          a4 a b c d2 c4 d a (b) c b a2\resp
          a2 a4 b g2 \allowBreak g4 g c2 (b4 c) a2\fermata
          \bar"|."
        } \tonVIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d2 d4 d e2 e4 e fis fis e d e2 e g4 g g1 fis2
          fis4 fis g a b2 a4 b fis (g) a g fis2 fis fis4 fis e2 e4 e a1 fis2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto "soprano"
   {
      Un fleu -- ve d’eau vi -- ve a ré -- jou -- i l’É -- gli -- se, al -- lé -- lu -- ia_!
      Dieu a e -- xal -- té son En -- fant bien_- ai -- mé, 
      l’Em -- ma -- nu -- el, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d4 d2 a'4 b c2 c4 c d d c b c2 c d4 e d2 (c4 d) d2
          d\breve*1/8 s s s s s s s s s s s d2 d d4 d b2 b4 b e2 (d4 e) d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d2 d4 d d2 d4 d g g g g d2 d\resp
          g4 g g1 d2 d\breve*1/8 s s s s s s s s s s s d2\resp
          d d4 d e2 e4 e a,1 d2 \fermata
        } \tonVIIah 
      }
   >>
>>