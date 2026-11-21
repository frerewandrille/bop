\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key f \major \time 3/4 %\cadenzaOn %
          \tempo "Très calme" %2 = 52
          f2 g4 a2 g4 a2 f4 g2. s4 e (f) g g g g f e f2 f4\fermata \bar"|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { %\cadenzaOn
          c2 c4 f2 e4 f2 c8 (d) e2. bes'4\rest c,  (d) e e e e c c c2 c4
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      Re2 -- ce4 -- vez2 le4 Corps2 du4 Christ,2. \skip4
      bu2 -- vez4 à la source im -- mor -- tel2 -- le_!4
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 %\cadenzaOn
          a2 bes4 c2 bes4 c2 a4 
          <g \tweak font-size #-3 \parenthesize bes>2. 
          s4 g (a) bes bes bes bes a g a2 a4
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { %\cadenzaOn
          f2 c4 f2 c4 f2 f,8 (a) c2. d4\rest c2 c4 c c c c c <f, f'>2 <f f'>4\fermata
        }
      }
   >>
>>