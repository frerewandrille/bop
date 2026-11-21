\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 6/4 }


\transpose d b,
\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
     \partial 1 d4\< g g a bes2 c4 d2 ees4 f f ees d4~ d2\ff d2.
     c\ppp\> d2 c4 bes2. a2 bes4 c c bes a2.\!
   }
   \new Staff = "femmes" \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure  \tempo  2. = 72
         \partial 1 d4 g-> g a bes2-> c4 d2-> ees4 f-> f ees d2.~ d\allowBreak\break
         c d2 c4 bes2.\breathe a2 bes4 c-> c bes \noBreak a2.\fermata
         \bar"|."
       } \cadenzaOn \tonXaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d4 g g a g2 f4 2 4 bes4 4 c bes2.~ 2.
         a a2 a4 g2. fis2 g4 a a g fis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Bé -- ni soit ce -- lui qui vient au Nom du Sei -- gneur_:
     Le Sei -- gneur Dieu qui nous est ap -- pa -- ru_!
   }
   \new Staff = "ténor" \with {\remove Time_signature_engraver }
   << \new Voice
      {
        \relative c'
        { \clef "treble_8" \armure 
          \partial 1 d4 d-> d d d2 c4 bes2 4 4 4 f bes2.~ 2.
        } 
      }
   >>
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \relative c'
        { \clef "bass" \armure \voiceOne
          \partial 1 s4 \repeat unfold 3 \skip1. 
          f2. d2 d4 d2.\breathe d2 4 f! f d d2.
        } \cadenzaOn \tonXah
      }
      \new Voice = "basse"
      { \relative c
        { \clef "bass" \armure 
          \partial 1 r4 r2 d4 g-> g a bes2-> c4 d2-> ees4 f-> f ees d2. \voiceTwo
          f, fis2 4 g2. d2 g4 f!-> f g d2.\fermata
        } 
      }
   >>
   \new Lyrics 
   \lyricsto "basse"
   {
     Bé -- ni soit ce -- lui qui vient au Nom du Sei -- gneur_:
     %     Le Sei -- gneur Dieu qui nous est ap -- pa -- ru_!
   }
>>