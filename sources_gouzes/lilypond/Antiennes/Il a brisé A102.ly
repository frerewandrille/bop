\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     bes2\ppp^\< bes4 a bes2 
     bes4 c bes a bes c bes2\!\resp
     bes4 d d2. d4 c2^\> bes a1\!
     a2^\< a4 g a2 bes4 (a) 
     g2. (fis4) g2\!\resp
     fis4 (g) a2. a4^\> g2 g fis\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif et dansant" 2 = 120
         bes2-. bes4-. a-. bes2-. 
         bes4-. c-. bes-. a-. bes-. c-. bes2\resp
         bes4 d d2. d4 c2 bes^\markup{\italic élargir} a1\fermata\resp
         \tempo "Vif et marqué" a2-. a4-. g-. a2-. bes4-. (a-.) 
         g2. (fis4) g2\resp
         fis4 (g) a2. a4 g2^\markup{\italic élargir} g fis\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g2 g4 g g2 g4 g g g g g g2 g4 f f2. f4 f2 f f1
         f2 f4 f f2 f d1 d2 d f2. f4 d2 d d
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Il a bri -- sé les puis -- san -- ces de la mort
     par le scep -- tre de sa croix.
     Il é -- ta -- blit son rè -- gne sur tou -- tes les na -- tions.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 c d2 d4 ees d c d ees d2 d4 d d2. d4 ees2 d c1
          c2 c4 bes c2 d4 (c) bes2. (a4) bes2 
          a4 (bes) c2. c4 bes2 bes a
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2-. g4-. g-. g2-. g4-. g-. g-. g-. g-. g-. g2\resp
          g4 bes bes2. bes4 a2 bes f1\fermata\resp
          f2-. f4-. f-. f2-. bes,4-. (f'-.) g2. (d4) g2\resp
          d4 (g) f2. f4 g2 g d\fermata
        } \tonIIah
      }
   >>
>>