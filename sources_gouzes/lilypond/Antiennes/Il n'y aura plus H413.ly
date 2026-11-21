\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose d e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure %\tempo  2. = 50
          \partial4 d4 a' a a g2 a4 b b c \time2/2 b (a2 g4\fermata)
          a2.\fermata\resp a4 \time 3/4
          c c b a a g f2. e\fermata\breathe d2 e4 \noBreak e2.\fermata
          \bar "|."
        }\cadenzaOn \tonIVef
        %\tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 d4 d d d d2 c4 d d e c2 (d) c2. 
          c4 e e e e e e d2 (c4) b2. b2 b4 b2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Il n’y au -- ra plus de mort ni de pei -- ne,
     car Dieu es -- suie -- ra tou -- te lar -- me de leurs yeux.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \partial4 d4 f f f d2 e4 g g g e2 (d) e2.
          e4 a a a a a a a2. gis a2 a4 gis2.
        }\cadenzaOn \tonIVeh
        %\tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 d4 d d d b2 a4 g g g a2 (b\fermata) a2.\fermata\resp
          a4 a a a c c c d2. e\fermata\breathe f2 f4 e2.\fermata       
        }
      }
   >>
>>