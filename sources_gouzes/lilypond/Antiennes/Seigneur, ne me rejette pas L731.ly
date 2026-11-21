\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose d c
\new ChoirStaff
<< \new Dynamics 
   {
     d2*1/2^\< s4^\> b4.\!
     b8^\< b [b b b]\! c2 c c4^\< b d2\! (cis^\>) d2\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 4 = 100
          d2*1/2\fermata s4 b4.\fermata\resp
          b8 b [b b b] c2 \resp c c4 b d2. (cis4) d2\fermata
          \bar"|."
        } \tonIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          a2 g4. g8 g [g g g] g2 a g4 g f (g a2) a
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur_! Ne me re -- jet -- te pas dans ta co -- lè -- re_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          f2 d4. d8 d [d d d] e2 f e4 d d2 (e) fis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2\fermata g4.\fermata\resp
          g8 g [g g g] c,2\resp f c4 f bes2 (a) d,\fermata
        } \tonIgh
      }
   >>
>>