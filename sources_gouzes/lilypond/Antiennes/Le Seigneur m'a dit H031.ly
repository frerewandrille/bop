\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large" %2 = 52
         e4-> e d-> d b2.\resp b4 b2 a b1\fermata\resp
         b2 a4 c b2 a4 b g2 g fis1\fermata\resp
         fis2 fis4 g a2. a4 d2 d b1\fermata\bar"|"
         e2 e4 e d2 d4 d b2 b4 b g a b2 b\resp
         e,2^\ppp fis4 g a2 a4 a g2 fis4 d e2\fermata e\fermata
         \bar"|."
       } \transpose a b \tonIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 g fis fis gis2. gis!4 fis2 fis fis1
         g2 e4 fis g2 e4 e e2 e dis1 dis!2 dis4 e fis2. fis4 fis2 fis g1
         g2 g4 g fis2 fis4 fis g2 g4 g e fis g2 g
         e2 e4 e e2 e4 e e2 d4 b b2 b
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur m’a dit_:
     "“Tu" es mon Fils.
     Moi, au -- jour --\apostrophe d’hui, je t’ai en -- gen -- "dré”,"
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Le Fils u -- ni -- que, vi -- vant dans le sein du Pè -- re, 
     naît au -- jour --\apostrophe d’hui de la Vier -- ge Ma -- ri -- e.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b d d e2. e4 cis2 cis dis1 e2 c4 c e2 c4 c b2 b b1
          b2 b4 b d2. d4 a2 a d1 b2 b4 b d2 d4 d d2 d4 d c c d2 d
          c c4 c c2 c4 c b2 a4 fis g2 g
        } \transpose a b \tonIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> e b'-> b e,2.\resp  e4 fis2 fis b1\fermata\resp
          e,2 a4 a e2 e4 e e2 e b1\fermata\resp b2 b4 e d2. d4 d2 d <g, g'>1\fermata
          e'2 e4 e b'2 b4 b g2 g4 g c a g2 g\resp
          a2 a4 a a2 a4 a e2 b4 b e2\fermata e \fermata
        } 
      }
   >>
>>