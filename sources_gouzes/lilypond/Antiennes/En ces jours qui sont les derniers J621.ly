\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 2/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 56
         a4 a-> a a-> c b-> g a2.\resp a4 a-> a g-> g a-> e e2\resp
         e4-> e e-> e g2 g4-> g b2 (a4 e) e2\fermata
         \bar"|."
       } \tonIVbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e e e a g e e2. e4 e e e e cis b cis!2
         cis!4 cis cis cis d2 d4 d g2 (e4 d) cis!2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     En ces jours qui sont les der -- niers,
     Dieu nous a par -- lé par son Fils,
     res -- plen -- dis -- se -- ment de sa gloi -- re.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c c e d b cis2. cis!4 cis cis b b a g a2
          a4 a a a b2 b4 b d2 (cis!4 b) a2
        } \tonIVbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 a-> a a-> a e-> e a,2.\resp
          a4 a-> a e'-> e a,-> e' a,2\resp
          a4-> a a-> a g2 g4-> g g2 (a4 e') <a, a'>2\fermata
        } 
      }
   >>
>>