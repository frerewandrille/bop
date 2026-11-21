\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 66
          d4-- d-- d-- a2 b8 ([cis]) d4 d b cis2.\resp
          a4 a a b2 a4 g2 g4 fis2.\bar"|"
          fis4 g fis g2 a4 b2 cis4 d2 d4\resp
          d4 a fis g2 g4 fis2-- (e4--) fis2.\fermata
          \bar"|."
        } \tonVef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          fis4 fis fis e2 e4 fis fis gis <e a>2.
          cis4 cis cis b4. (cis8) d4 e2 e4 dis2.
          dis!4 e dis e2 fis4 g2e4 fis2 fis4
          fis d dis e2 e4 e (dis! cis) dis!2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Je vous en -- voie par -- mi les na -- tions, 
      al -- le -- lu -- ia, al -- le -- lu -- ia_!
      Pour pro -- cla -- mer mon é -- van -- gi -- le, 
      jus -- \apostrophe qu’aux loin -- tains du mon -- de.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a a a2 a4 b b b a2. a4 a a d2 a4 b2 b4 b2.
          b4 b b b2 d4 d2 g,4 a2 a4 a a b b2 b4 b2. b
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4-- d-- d-- cis2 cis4 b b e a,2.\resp
          fis'4 fis fis g2 fis4 e2 e4 b2.\fermata
          b4 e b e2 d4 g4. (fis8) e4 d2 d4\resp
          d d b e2 e4 fis2.-- b,\fermata
        } \tonVeh
      }
   >>
>>