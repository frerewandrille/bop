\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          d2 d c d4 c a a f g a2 \allowBreak d,4 e f2 f g4 (f) g2 a2\fermata\resp
          d2 d c d4 c a \allowBreak d, e f g2 f4 g a2 a\resp
          d,4 e f2 f4 f g2 f4 g a2 \allowBreak d, c d\fermata
          \bar"|."
        } \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f e f4 e d d d d f2 bes,4 bes d2 c d d4 (e) f2
          f f e f4 e d d d c d2 d 4 e f2 f 
          d4 d c2 c4 c d (e) f e f2 d a4 (g) a2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le Sei -- gneur a bâ -- ti u -- ne mai -- son
      à Da -- vid son ser -- vi -- teur_:
      dans la chair de Ma -- rie, il a choi -- si sa de -- meu -- re,
      et son trô -- ne se -- ra é -- ta -- bli pour tou -- jours.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a a a4 a f f bes bes c2 f,4 f bes2 f bes bes c
          a2 a a a4 a f f g a bes2 a4 bes c2 c
          f,4 g a2 a4 a bes2 a4 bes c2 g e f
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d a a4 a bes bes a g f2 bes4 bes bes 2 a g g f\fermata\resp
          d' d a a4 a bes bes bes a g2 a4 g f2 f\resp
          bes4 bes a2 a4 bes g2 g4 g f2 g a d\fermata
        } \tonIeh
      }
   >>
>>