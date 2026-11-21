\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2 = 62
          d4 e2. d4 d-> b d2.\fermata\resp
          b4 b2 g4 b b2 b4 a a2.\fermata\resp
          b4 b2 g4 b c2 b4 a b2.\resp
          b4^\markup\italic"élargir" b2. b4 g2 a b\fermata b\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g2. g4 fis e fis2. e4 e2 g4 e g2 g4 e fis2.
          g4 g2 d4 g e2 e4 e dis2. dis!4 e2. fis4 g (fis) e2 dis! dis
        }    \tonIIIcf
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le Ver -- be s’est fait chair_:
      Bé -- nie soit la Mè -- re de Dieu,
      la Vier -- ge qui porte en son sein
      le Dieu d’a -- vant les siè -- cles_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 c2. b4 a g a2. g4 g2 b4 b d2 d4 cis d2.
          d4 d2 b4 g g2 g4 e fis2. fis4 g2. b4 b2 a fis fis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 c,2. g'4 d-> e d2.\fermata\resp
          e4 e2 e4 g g2 g4 a d,2.\fermata\resp
          g4 g2 g4 e c2 e4 c b2.\resp
          b4 e2. dis4 e (dis!) cis2 b\fermata b\fermata
        } \tonIIIch
      }
   >>
>>