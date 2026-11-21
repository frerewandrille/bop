\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 2/2 \cadenzaOn \tempo "Paisible et joyeux"
          g4 g g (a) f g g2. \breathe \allowBreak 
          g4 c^> d bes2 (a4) f a^> bes g2\fermata \breathe\allowBreak
          f4^> g bes2 c4 d d c bes2 a4 bes g2. \breathe\allowBreak 
          g4 f^> f g a f f d2 d \allowBreak f4 g bes4 (a) f a g2\fermata \bar "|."
        } \transpose g bes \tonIIif
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 d d2 d4 d d2. d4 f f f2. f4 f f d2
          d4 d d2 f4 f g g f2 f4 f d2.
          d4 d d d d d d d2 d d4 d g (d) d f d2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      Sur4 les eaux2 du4 Jour -- dain,2. la4 voix du Père2. a4 re -- ten -- ti_:2
      Il4 a fait2 re4 -- po -- ser sur nous2 son4 Es -- prit2.
      en4 le don -- nant en plé -- ni -- tu2 -- de à4 son Fils2 bien-4 ai -- mé.2
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 2/2 \cadenzaOn
          bes4 bes bes (c) a a bes2. bes4 a bes d2 (c4) a c d bes2
          c4 c bes2 a4 bes bes c d2 c4 d bes2.
          bes4 a a bes c a a bes2 bes c4 c d (c) a c bes2
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4 g g2 d4 d g2. \breathe g4 f-> f f2. a4 f-> f g2\fermata \breathe
          a4-> a g2 f4 f ees ees d2 f4 f g2. \breathe
          g4 d-> d d d f f g2 g a4 a g2 a4 f g2\fermata
        } \transpose g bes \tonIIih
      }
   >>
>>