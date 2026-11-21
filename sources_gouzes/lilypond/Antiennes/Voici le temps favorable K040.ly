\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
          d^\< d d d d d d2\! (c4) bes2.
          bes4 bes bes c2.^\> c2 c4 a2\!
          a4^\< \bar"|"\time 2/2 bes2 bes4\! bes a2^\> g fis! g1\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 66
          d4-> d d d-> d d d2 (c4) bes2.\resp
          bes4-> bes bes c2. c2 c4 a2\resp
          a4 \noBreak \bar"|"\time 2/2 bes2 bes4-> bes a2 g fis! g1
          \bar"|."
        } \transpose c bes, \tonIIIaf % Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g fis fis fis g2 (fis!4) g2. g4 g g g2. a2 a4 a2
          a4 g2 g4 g ees2 d d d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Voi -- ci le temps fa -- vo -- ra -- ble, 
      voi -- ci le Jour du sa -- lut_:
      Ve -- nez, a -- do -- rons le Sei -- gneur.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d d d d d2. d d4 d d c2. c2 c4 d2 d4 d2 d4 d c2 bes a bes1
        } \transpose c bes, \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4-> bes bes a-> a a bes2 (a4) g2.\resp 
          g4-> g f ees2. f2 f4 fis2\resp fis!4 g2 g4-> g c,2 d d <g, g'>1
        } 
      }
   >>
>>