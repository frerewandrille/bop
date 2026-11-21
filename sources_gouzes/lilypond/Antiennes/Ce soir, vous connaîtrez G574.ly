\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 2/4 }
resp = { \breathe\allowBreak }

\transpose d c
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Léger et frais" 2 = 62
         d4 d2. d4 b-> e d-> d b-> d d2\resp b-> b4-> b g2 (a) a2.\fermata\bar"|"
         b4 b2-> b4-> b g-> b b1 b2\fermata
         \bar"|."
       } \tonIIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g4 g2. g4 g g g g g g fis2 g g4 g e1 e2. 
         g4 g2 g4 g d fis e2 (dis4 cis) dis!2
       }
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ce soir, vous con -- naî -- trez vo -- tre Sau -- veur, car le Sei -- gneur vient_!_
     De -- main vous ver -- rez sa gloi -- re_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b2. b4 d c b b g g a2 g g4 g b2 (cis) cis!2. 
          d4 d2 d4 d b b g2 (fis4 e) fis2
        } \tonIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g2. g4 g-> c, g'-> g e-> e d2\resp e-> e4-> e e2 (<a, a'>) q2.\fermata
          g'4 g2-> g4-> g g-> dis e2 (b) b\fermata
        } 
      }
   >>
>>