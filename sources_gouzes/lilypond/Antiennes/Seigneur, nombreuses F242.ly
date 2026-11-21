\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  2. = 60
          e4 f2 f4 e2 e4 f->^\> f a g2. e\fermata\!\resp
          a4-> a a g2 g4 f2 g4 e2. e\fermata
          \bar"|."
        } \tonIVef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c4 d2 d4 b2 b4 d d c d2. cis e4 e e e2 e4 d2 e4 e2. e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, nom -- breu -- ses sont tes ten -- dres -- ses.
      Dé -- li -- vre_- moi par ta Pa -- ro -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a2 a4 gis2 gis4 a a a b2. a 
          cis4 cis cis b2 b4 a2 b4 cis!2. cis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 d,2 d4 e2 e4 d-> d f g2. a\fermata\resp
          a4-> a a e2 e4 f2 e4 a2. a\fermata
        } \tonIVeh
      }
   >>
>>