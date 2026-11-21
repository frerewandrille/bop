\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }


\transpose d e
\new ChoirStaff
<<     \new Dynamics 
       { \partial 4 d4^\pp^\< d d d c d2 d4 e f2 d d^\p\!
         d4^\< d d d f2 f4 f g2 \allowBreak g a4 a c2 a4 g a1\f\!
         \bar "|"
         b4\rest a4\mf^\< a a f2^\> g a2.\! 
         a4\mf^\< a a a a f2. \allowBreak f4 f f bes2 bes a1\f\!
         \bar "|."
       }
       \new Staff %\with {\remove Time_signature_engraver }
       << 
         \new Voice = "soprano"
         { \voiceOne \relative c'
           { \clef "treble" \key f \major \time 2/2 \cadenzaOn \tempo  2 = 100
             \partial 4 d4 d^> d d^> c d2 d4 e f2 d d\fermata\resp
             d4^> d d^> d f2 f4 f g2 \allowBreak g a4 a c2 a4^- g^- a1\fermata
             \bar "|"
             \silN a4 a^> a f2 g a2.\fermata\resp 
             a4 a^> a a^> a f2. \allowBreak f4 f f bes2 bes a1\fermata
             \bar "|."
           } \tonIVdf
         }
         \new Voice = "alto"
         { \voiceTwo \relative c'
           {
             \partial4 a4 a a a a bes2 bes4 bes bes2 c4 (bes) a2
             a4 a a a d2 d4 d d2 d4 (e) f f e2 d4 d cis1
             s4 cis! cis cis d2 d cis!2. e4 e e e e d2. d4 d d d2 e f1
           }          
         }
       >>
       \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
       { 
         Voi -- ci que nous mon -- tons à Jé -- ru -- sa -- lem, 
         où le Fils de l’hom -- me se -- ra li -- vré aux mains des pé -- cheurs_:
         Il se -- ra mis à mort, mais le troi -- siè -- me jour, il res -- sus -- ci -- te -- ra_!
       }
       \new Staff %\with {\remove Time_signature_engraver }
       << \new Voice = "ténor"
          { \voiceOne \relative c
            { \clef "bass" \key f \major \time 2/2\cadenzaOn
              \partial4 f4 f f f f f2 f4 f g2 g a f4 f f f f2 f4 f bes2 bes c4 c a2 f4 d e1
              \silN e4 e e d2 d e2. a4 a a a a a2. a4 a a bes2 bes c1
            } \tonIVdh
          }
          \new Voice = "basse"
          { \voiceTwo \relative c
            {
              \partial4 d4 d_> d c_> c bes2 a4 a g2 g d'\fermata\breathe 
              d4_> d c_> c bes2 a4 a g2 g f4 f a2 bes4_- bes_- a1\fermata
              s4 a4 a_> a bes2 bes a2.\breathe
              cis4 cis_> cis cis_> cis d2. d4 d_> d g2 g f1\fermata
            }
          }
       >>
>>