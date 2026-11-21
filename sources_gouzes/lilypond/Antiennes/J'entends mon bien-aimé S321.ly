\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 84
          bes4 bes-> bes c-> g bes2.\fermata\resp
          bes4 c2 d d2.\resp \tempo "Plus vif, staccato" 2 = 144
          d4-- d---> d-- c8 [d] ees4 (d8 [c]) d4\resp
          bes8 [c] d4 d c8 [d^\markup{\italic rall.}] ees4 (bes8 [c]) d2\fermata
          \bar"|."
        } \tonVIIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 ees f g ees f2. f4 g2 a bes2. 
          bes4 f bes g8 [a] bes4 (a8 [g]) bes4 
          f8 [g] bes4 bes g8 [a] bes4 (g) bes2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      J’en -- tends mon bien_- ai -- mé_:
      Voi -- ci qu’il vient, sau -- tant par les mon -- ta -- gnes,
      bon -- dis -- sant sur les col -- li  -- nes_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 c d ees c d2. d4 ees2 f f2.
          f4 f f ees8 [f] g4 (f8 [ees]) f4 
          d8 [ees] f4 f ees8 [f] f4 (ees) f2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 f-> d c-> ees bes2.\fermata\resp <bes bes'>4 q2 q q2.\resp
          bes'4-- d---> bes-- ees8 [d] c2 bes4\resp
          d8 [c] bes4 d ees8 [d] c4 (ees) bes2\fermata
        } \tonVIIIch
      }
   >>
>>