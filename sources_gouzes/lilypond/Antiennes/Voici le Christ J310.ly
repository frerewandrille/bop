\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     fis4 fis2 g4 a2 a4 c2 c4 b2
          b4 d2 d4 c2 c4 b2. a2
          a4\p^\> a2 a4 a2 g4 fis2.\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Lent, doux et majestueux" 4 = 90
          fis4 fis2 g4 a2 a4 c2 c4 b2\resp
          b4 d2 d4 c2 c4 b2. a2\fermata\resp
          a4^\markup\italic"bien balancé" a2 a4 a2 g4 fis2.\fermata
          \bar"|."
        } \tonVIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d2 d4 d2 d4 d2 d4 d2 d4 g2 g4 g2 fis4 g2. fis2 
          fis4 g2 g4 g (fis) e fis2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Voi -- ci le Christ qui dans sa chair 
      a é -- pou -- sé l’É -- gli -- se_!
      Ve -- nez, a -- do -- rons_- le_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a2 b4 c2 c4 a2 a4 g2 g4 b2 b4 a2 a4 g2 (b4) d2 
          d4 e2 e4 e (d) cis <a d>2.
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d2 d4 d2 d4 fis2 fis4 g2 \breathe
          g4 g2 g4 d2 d4 d2. d2\fermata\breathe
          d4 a'2 a4 a2 a4 d,2.\fermata
        } 
      }
   >>
>>