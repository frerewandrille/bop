\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          f8 [g] g4 (a8 [bes] c [d]) c4. \fermata\bar "|"
          c8 a4 bes8 [a] g4.\resp a8 g [f] g [bes] bes4.\bar "|"
          c8 bes8 ([a]) g4 g\fermata
          \bar"|."
        } \tonIIgf
        %\tonIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d8 [d] ees4 (c8 [d] ees4) f4.
          f8 f4 f8 [f] d4. d8 d [d] c [c] d4.
          c16 ([d]) ees4 d d
        }    
      }
   >>
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia_! 
      Cher -- chez le Sei -- gneur qui rè -- gne dans les cieux, 
      al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 [bes] bes4 (a8 [f] g4) a4.
          a8 c4 d8 [c] bes4. bes8 c [a] g [g] f4.
          g8 c4 c bes
        } \tonIIgh
        %\tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d8 [g16 (f)] ees4 (f16 [ees d8] c4) f4.\fermata
          f8 f4 d8 [f] g4.\resp g8 c, [d] ees [ees] f4.
          ees8 c4 g' g\fermata
        } 
      }
   >>
>>