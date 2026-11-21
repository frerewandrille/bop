\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silB = { \oneVoice r2 \voiceOne }

\transpose g e
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         g4-> g f g-> bes d c-> bes a bes2 (g4) g2.\resp
         g4-> g f g2 a4 bes-> (a) bes g2.\bar"|"
         \silB \tempo "Calme" ees'4^\pp ees-> ees ees d-> d d 
         bes-> a bes c2.\fermata
         \bar"|."
       } \transpose a g \tonIgf
       %\transpose a bes \tonVIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         ees4 ees d ees f g g f f f2. 
         ees ees4 ees d ees2 f4 g (f) g ees2.
         s2 g4 g g g f f f f f f <ees g>2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La Vé -- ri -- té s’est le -- vée de la ter -- re, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Le Ver -- be de Dieu est des -- cen -- du du ciel.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c c d d ees d d d2. c c4 c c c2 c4 d2 d4 c2.
          \silB g4 g g g bes bes bes d d d c2.
        } \transpose a g \tonIgh
        %\transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c4-> c c c-> g' bes c-> c c g2 (bes4) c2.\resp
          c4-> c c c2 c4 g2-> g4 c2.
          s2 c,4 c-> c c c-> c c c-> c c c2.\fermata
        } 
      }
   >>
>>