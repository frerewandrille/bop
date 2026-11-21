\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose bes a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Large" 2 = 52
          bes2 bes4 a g g a a f f g g d2\fermata d\fermata\resp
          bes'2 bes4 bes a a bes bes g2 (a) a\fermata\resp
          d2 d4 d bes2^\markup\italic"rall." c c\fermata
          \bar"|."
        } \tonVIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f4 f d d f f d d ees ees bes2 bes
          g' g4 g f f g g e2 (f) f a a4 a g2 g a
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Tu es bé -- ni, Sei -- gneur du ciel et de la ter -- re_:
      Tu nous as ré -- vé -- lé ta gloi -- re 
      en ton Fils bien_- ai -- mé_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 c bes bes d d a a c c g2 g
          d' d4 d d d d d c1 c2 d d4 d d2 e f
        } \tonVIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          <bes bes'>2 q4 f' g g d d f f c c 
          d2\fermata <g, d'>\fermata\resp
          g' g4 g d d g g c,2 (f) f\fermata\resp
          fis fis4 fis g2 c, f\fermata
        } 
      }
   >>
>>