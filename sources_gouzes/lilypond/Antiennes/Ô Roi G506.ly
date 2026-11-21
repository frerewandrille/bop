\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }

%\transpose f d
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 69
         f4 (bes2. a4 bes g) a2 g4 f g2.\fermata\resp
         g4-> f g-> bes g-> a g-> f f2.\resp
         g4 d-> g g2 (a4 bes c2 d4 c d ees) d2.\resp
         4 d-> d c-> c bes-> a g-> g a-> bes bes2 f\resp
         f4-> bes a2. bes4 2 bes4-> a g-> a  a2 \allowBreak g4-> f f2 g4-> f d2 d\resp
         f4-> g bes-> a f a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4~ (f2 e d) e d4 d d2. d4 d d d e! e d d d2. 4 d d d1 (ees2 f4 g f g) f2.
         4 f f ees ees d d d d c d d2 c c4 f f2. f4 f2 f4 f d c c2 c4 d d2 d4 d d2 d
         d4 d d f d d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Roi des na -- tions, dé -- si -- ré des peu -- ples et des rois,
     Pierre an -- gu -- lai -- re qui, des paï -- ens et d’I -- sra -- ël, fait un seul peu -- ple,
     Viens sau -- ver ce -- lui que tu as for -- mé du li -- mon de la ter -- re,
     Viens Sei -- gneur, viens nous sau -- ver_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 (d'2 c bes) c a4 a bes2.  4 c bes4 4 c c a a a2.
          bes4 c bes4 2 (a g4 a bes2. g8 [a]) bes2. 4 4 4 g a bes4 4 4 4 c bes4 2 a
          a4 d c2. d4 d2 d4 d bes c c2 c4 a a2 a4 a bes2 2
           c4 c d d c c bes2
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 (bes,2 c d) c d4 d g2.\fermata\resp
          g4-> a g-> g c,-> c d-> d d2.\resp 
          g4 a-> g g2 (f ees d4 ees d c) bes2.\resp 4 
          bes-> 4 c-> c d-> d ees-> 4 ees-> d d (ees) f2\resp
          f4-> f f2. d4 d2 d4-> d ees-> ees ees2 4-> f f2 f4-> f g2 g\resp
          a4-> a g-> f a f g2\fermata
        } 
      }
   >>
>>