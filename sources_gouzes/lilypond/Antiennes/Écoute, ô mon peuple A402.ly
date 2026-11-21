\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2. = 48
         e4 c'2. e2 e4 d2. b2\resp
         b4 c2 c4 c-> d d b2.\resp \time 2/4
         b\breve*1/8^\markup\italic"récité" c4 \tempo 2 = 60 c2.\resp
         c4 a2. a4 a-> b b2\fermata b\fermata
         \bar"|."
       } \tonIIIbf
       %\tonIIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e2. g2 e4 fis2. d2 d4 e2 e4 e fis fis e2.
         e\breve*1/8 e4 e2. e4 d2. d4 d dis dis2 dis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     É -- coute, ô mon peu -- ple_: 
     Je suis le Sei -- gneur ton Dieu.
     "C’est la miséricorde que" je veux, 
     et non le sa -- cri -- fi -- ce.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 a2 (b4) c2 c4 b2. b2 b4 a2 a4 a b b g2.
          g\breve*1/8 a4 a2. a4 fis2. fis4 fis fis fis2 fis
        } \tonIIIbh
        %\tonIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 a,2. a2 a4 d2. fis2\resp fis4 e2 e4 e-> d d e2.\resp
          e\breve*1/8 a,4 a2.\resp 
          a4 d2. d4 d-> b b2\fermata b\fermata
        } 
      }
   >>
>>