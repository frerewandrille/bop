\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     e2^\< e4 e e2. e4 e e a2 a4 a gis2.\!\resp 
     e4^\< e1 f2^\> f4 f e2. e4 e2 e e1\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Alerte" 2 = 80
          e2 e4 e e2. e4 e e a2 a4 a gis2.\resp 
          e4 e1 f2 f4 f e2. e4 e2\fermata e\fermata e1\fermata
          \bar"|."
        } \tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c2 b4 b c2. c4 c c c2 c4 d e2. c4 c1 d2 d4 c b2. b4 c2 b cis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Com -- me le Pè -- re res -- sus -- ci -- te les morts,
     le Fils don -- ne la vie à qui il veut.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 gis4 gis a2. a4 a a a2 a4 a b2. 
          a4 a1 a2 a4 a gis2. gis4 a2 gis! a1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 e4 e a2. a4 a g f2 f4 f e2.\resp
          a4 a1 d,2 d4 d e2. e4 e2\fermata e\fermata a,1\fermata
        } \tonIVch 
      }
   >>
>>