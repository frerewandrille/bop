\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose g f
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
         b4 d-> d e d-> d c b2 g4 a2 b4 b2.\fermata\resp
         d4-> d e d2 b4 c2 c4 b2.\fermata
         \bar"|."
       } \transpose a b \tonVIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 g g g fis fis e d (g) g e (fis) g g2.
         g4 g g g2 g4 g2 a4 g2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Il est a -- vec nous, le Sei -- gneur de l’u -- ni -- vers,
     l’Em -- ma -- nu -- el, al -- lé -- lui -- a_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 b b c8 ([b]) a4 a g8 ([a]) b4 (d) e c2 d4 d2.
          b4 b c b2 d4 e2 e4 d2.
        } \transpose a b \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g-> g c, d-> d e8 ([fis]) g2 c8 ([b]) a2 g4 g2.\fermata\resp
          g4-> g c,8 ([e]) g2 g4 c2 c4 g2.\fermata
        } 
      }
   >>
>>