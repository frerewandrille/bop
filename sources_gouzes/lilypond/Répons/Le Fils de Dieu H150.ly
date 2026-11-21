\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure %\tempo "" 2. = 50
          \revert Staff.TimeSignature.style
          \partial4 
          \repeat volta 2 {
            g4 g2 g4 b2 c4 d2 e4 d2 } 
          \repeat volta 2 {
            \silN d2 e4 d2 c4 b2. g2 }
          g4 a2 a4 b2 a4 g2 (a4) b2
          b4 d2 (e4) d2 (c4) b2 (a8 b g2) g4 a2 (b4) a2. g~ g
          \bar "|."
        }\cadenzaOn \transpose a b \tonVIaf % Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 
          \repeat volta 2 {
            d4 d2 d4 d (g) g a2 a4 fis2 }
          \repeat volta 2 {
            s4 g2 g4 g2 e4 e2. e2 }
          e4 fis2 fis4 g2 fis4 e2. dis2
          e4 fis2 (g4) g2 (e4) e2.~ e2 e4 cis (d2) d4 (e d) d2.~ d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Le Fils de Dieu, l’Em -- ma -- nu -- el
     pour nous vient de naî -- tre.
     Nous a -- vons vu sa gloi -- re,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          {           
            \partial4 
            \repeat volta 2 {
              b4 b2 b4 b8 (c d4) e fis (e8 d) cis4 d2 } 
            \repeat volta 2 {
              \silN b2 c4 b2 a4 g2 (a4) b2 }
            b4 d2 d4 d2 d4 b2 (a4) fis2
            g4 b2 (g4) b2 (a4) g2 (a4 b2) b4 a (fis g) fis (e fis) g2. (b)
          }        
        } \cadenzaOn \transpose a b \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 
          \repeat volta 2 {
            <g g'>4 q2 q4 g'2 e4 d2 a'4 d,2 }
          \repeat volta 2 {
            s4 g2 c,4 g2 a4 e'2. e2 }
          e4 d2 d4 g2 d4 e4. (d8 c4) b2
          e4 b2 (c4) g2 (a4) e'2.~ e2 e4 a, (d g,) d' (cis d) g,2.~ g
        }
      }
   >>
>>