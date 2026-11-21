\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2. = 72
         d4 d2 c4 f-> f g a2 a4 c-> c d a2.\resp
         a2 a4 a-> (g) a b-> (a) g a2\fermata\resp a2 a4 e-> e g f2 (e4) d2.\fermata
         \bar"|."
       } \tonIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d4 d2 c4 f f g a2 a4 f f d8 ([e]) f2. f2 f4 f (e) f g (f) e f2 f2 f4 e e e d2 (e4) \small f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci le Sei -- gneur qui vient a -- vec tous les Saints_!
     En ce jour res -- plen -- di -- ra u -- ne gran -- de lu -- miè -- re_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d4 d2 c4 f f g a2 a4 c c bes c2. c2 b4 c (d) c d (c) d c2 d2 d4 c c b! a (b2) a2.
        } \tonIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d2 c4 f-> f g a2 a4 a-> a g f2.\resp
          f2 g4 a-> (b) a g-> (a) b! a2\fermata\resp
          d,2 d4 a'-> a e f (g2) d2.\fermata
        } 
      }
   >>
>>