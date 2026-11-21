\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose b g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 60
          b2 b4 b a2 a b b g1\resp 
          d'2^\< d4 d e1 d2^\> d b1\fermata b\fermata\!\resp
          b2 b4 b a2 b g2. g4 c2. b4^\markup\italic"élargir" c2 c b1\fermata
          \bar"|."
        } \tonVIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g4 g fis2 fis fis fis d1 g2 g4 g g1 fis2 fis g1 g
          g2 g4 g fis2 fis e2. e4 e2. fis4 g2 fis g1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Bé -- ni sois_- tu, Sei -- gneur Jé -- sus, 
      toi no -- tre Pâque é -- ter -- nel -- le.
      Tu nous as re -- le -- vés de l’om -- bre de la mort.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 d c2 c d d b1 b2 b4 b c1 a2 a g1 g 
          d'2 d4 d c2 d b2. b4 c2. d4 e2 d d1
        } \tonVIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 g d2 d d d g1\resp 
          g2 g4 g c,1 d2 d g1\fermata g\fermata\resp
          g2 g4 g d2 d e2. e4 a2. a4 a2 d, g1\fermata
        } 
      }
   >>
>>