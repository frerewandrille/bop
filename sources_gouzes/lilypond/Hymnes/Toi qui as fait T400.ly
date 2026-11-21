\version "2.24.0"

\include "vowel-set.ly"


\new ChoirStaff 
<< \new Staff %\with {\remove Time_signature_engraver }	
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time 6/4 \tempo "Allant" 2. = 63
          d4 a' b g2^> a4 b^> c b a2.^> d2^> d4 c2^> b4 a^> g a b^> c b a2^> (g4) a2. 
          d,2^> d4 a'2. d4^> c b a2. b4^> (c a b2^>) g4 a2.\fermata \bar"|."
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        {
          d4 c b a (e') fis d d e fis (g fis) e2 e4 a2 g4 fis e d c d e fis2 (e4) d2. 
          d2 d4 c2. b4 a b c2. d4 (e fis g fis) e d2.
      } }
   >>
   \new Lyrics \lyricsto "soprano" {
     Toi qui as fait de Pierre et de Paul 
     les té -- moins jo -- yeux de la Bon -- ne Nou -- ve -- le, 
     gloire à toi, Sei -- gneur Jé -- sus_! Gloire à toi_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \time 6/4
          a2^\markup\italic"b.f." a4 a a a a2 a4 a a a a2 a4 a a a a2 a4 a a a a2 a4 a2.
          a2 a4 a a a a2 a4 a a a a2 a4 a a a a2.
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        {
          d1.-\markup\italic"b.f." d a a d d a d d2.\fermata
      } }
   >>
>>