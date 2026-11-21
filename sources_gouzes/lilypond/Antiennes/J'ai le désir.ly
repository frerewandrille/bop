\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 60
          a8-> [g] a4 c-> c d8-> ([c]) d4 a-> a f-> f g8 ([f]) g4 a2\fermata\resp
          a8 [g] f4 g-> g g8 ([f]) d4 f2\fermata\resp
          d8 ([e]) f4 g-> g g8 ([f]) g4 a2\fermata\resp
          d,4-> d g-> g g8^\markup{\italic rall.} ([f]) g4\fermata g2\fermata\resp
          d f8 ([e] c4) d2\fermata
          \bar"|."
        } \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f8 [e] f4 e8 ([d]) e4 d8 ([e]) d ([e]) f4 f f d d d8 ([e]) f2
          f8 [e] d4 d d d bes d2 d4 d f e d d8 ([e]) f2
          d4 d d d e8 ([d]) e4 d2 bes a4 (bes) a2
        }    
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      J’ai le dé -- sir de m’en al -- ler 
      et d’être a -- vec le Christ,
      mais je de -- meure au -- près de vous 
      pour la joie de vo -- tre foi.
      Que ta vo -- lon -- té, Sei -- gneur, soit fai -- te.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d c8 ([bes]) c4 bes bes8 ([c]) d4 d d bes bes8 ([a]) bes4 c2
          c8 [c] a4 bes bes bes g a2 bes4 bes c c bes bes c2
          bes4 bes bes bes c4 c bes2 g a4 (g) a2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4-> d a'-> a g-> g d-> d bes'-> a g g f2\fermata\resp
          f8 [f] f4 d-> d8 ([e]) f4 g d2\fermata\resp 
          g4 g c,-> c g' g f2\fermata\resp
          g4-> f d8-> ([f]) g4 c c\fermata bes4.\fermata (a8)\resp
          g2 d d\fermata
        } \tonIeh
      }
   >>
>>