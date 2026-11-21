\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn 
          \tempo "Paisible" 2. = 69
          f4 g2. (a) \breathe \allowBreak a2 a4 bes2 bes4 a2 g4 f2. d \breathe \allowBreak 
          g f2 g4 a2.\fermata\bar"|."
        }\tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 e1. f2 f4 g2 g4 e2 e4 d2. d d d2 d4 e2.
        }          
      }
   >>
   \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano"
      Heu4 -- reux1. ceux2 qui4 cher2 -- chent4 ta2 Pa4 -- ro2. -- le
      de tout2 leur4 cœur_!2.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          a4 c2. (cis) d2 d4 d2 d4 cis!2 cis4 d2. a bes a2 d4 cis!2.
        }\tonIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d4 %\set doubleSlurs = ##t 
          c2. (a)%(<a a'>) 
          \breathe
          d2 d4 g2 g4 a2 a4 d,2. f \breathe g d2 bes4 a2.\fermata
        }
      }
   >>
>>