\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }

\new ChoirStaff
<< \new Dynamics 
   {
     
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Recueilli mais allant" 2 = 69
         a2 f4-> g a2 f2. \resp f4 f-> f f2 e4-> e d2 (cis4-> d) e2.\resp
         e4^\markup\italic"soutenu et dynamique"
         \( d-> e f2 f4-> g a2 g4-> a bes2 a4-> f g2 g f1\fermata\)
         \bar"|."
       } \tonVIdf
     }
     \new Voice = "alto" %\with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
       { 
         f2 c4 c f2 c2. c4 c c c2 a4 a a1 c2. 
         c4 c c c2 c4 c f2 f4 f f2 f4 c d2 e c1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Christ, no -- tre Pâ -- que_!
     Tu as se -- mé dans les lar -- mes
     et mois -- son -- né dans la joie 
     de ta sain -- te ré -- sur -- rec -- tion.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 a4 bes c2 a2. a4 a a g2 g4 g f2 (e4 f) g2.
          g4 f g a2 a4 bes c2 bes4 c d2 c4 a bes2 bes a1
        } \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4-> f f2 f2.\resp
          f4 f-> f c2 cis4-> cis d2 (a4-> d) c2.\resp
          c4 c-> c f2 f4-> f f2 f4-> f bes,2 f'4-> f bes,2 c f1\fermata
        } 
      }
   >>
>>