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
         f4 (bes2. a4) bes (g) a4 (g f g) g2.\fermata\resp
         g4 g-> g g-> g a-> bes g-> (a) g-> f f2\resp
         g2. g4 d-> d g-> g a-> g a2 \allowBreak bes4 c d c d ees d2\resp
         d4-> d c-> bes bes-> a bes-> 4 c-> a bes (f) f2\resp
         f4-> bes a2. \allowBreak bes4 bes-> a g-> a a-> g f-> g g-> f d2\resp
         f4-> g bes-> a f a g2\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4~ (f2 e) d e! (d) d2. d4 d d d d e! e e2 d4 d d2
         d2. d4 d d d d c c c2 d4 ees f g f g f2
         f4 f ees4 4 d c d d ees4 4 d2 c
         c4 f f2. f4 f f d d c c d d d d d2
         d4 d d f d d d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô A -- do -- naï, guide et Sei -- gneur de la mai -- son d’Is -- ra -- ël,
     toi qui as ma -- ni -- fes -- té ton Nom dans la flam -- me du buis -- son,
     et qui as don -- né la Loi sur la mon -- ta -- gne,
     Viens Sei -- gneur nous ra -- che -- ter par la puis -- san -- ce de ton bras,
     Viens Sei -- gneur, viens nous sau -- ver_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 (d'2 c) bes c (a) bes2. 4 4 4 4 4 c c c2 a4 a a2
          bes2. 4 c c bes4 4 a a a2 a4 g8 ([a]) bes4 4 4 g8 ([a]) bes2
          4 4 g g8 ([a]) bes4 c bes4 4 g c bes2 a
          a4 d c2. d4 d d bes4 4 g g a a bes4 4 c2
           c4 c d d c c bes2
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 (bes,2 c) d c (d) g2.\fermata\resp 
          g4 g-> g g-> g c,-> c c2 d4-> d d2\resp
          g2. g4 a-> a g-> g f-> f f2 f4 ees d ees d c bes2\resp
          bes4-> 4 c-> c d-> ees d-> d c-> c d2 f\resp
          f4-> f f2. d4 d-> d ees4-> 4 ees4-> 4 f-> f g-> g a2\resp
          a4-> a g-> f a f g2\fermata
        } 
      }
   >>
>>