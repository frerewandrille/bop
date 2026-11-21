\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 60
          b4 b-> b c-> a a2 a4-> a a-> g b2\resp g2. g4 g-> a a2.\bar"|"
          b4 b-> b c2 a4 g b2\resp 
          g4-> g g2. g4 e-> g a2 a4-> b b2^\markup\italic"rall." (g4 a) b2\fermata
          \bar"|."
        } \tonVIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g g g g2 g4 g e d g2 d2. d4 e e fis2.
          g4 g g g2 g4 e g2 d4 d e2. e4 e e fis2 fis4 fis fis2 (e) g
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Tu as ou -- vert la por -- te du Pa -- ra -- dis 
      qu’Ève a -- vait fer -- mée_:
      tu es en -- trée, ô Ma -- rie, 
      et le Christ t’a é -- le -- vée dans sa gloi -- re_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d e c c 2 c4 c c b d2 b2. b4 b c d2.
          d4 d d e2 c4 c d2 b4 b c2. c4 c e d2 d4 d d2 (c) d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g-> g g-> g g2 g4-> g g-> g g2\resp
          g2. g4 e-> e d2.
          g4 g-> g g2 g4 g g2\resp g4-> g g2. g4 a-> g d2 
          d4-> d d2 (g) g\fermata
        } \tonVIeh
      }
   >>
>>