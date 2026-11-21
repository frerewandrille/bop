\version "2.24.0"

\include "vowel-set.ly"

resp = { \breathe \allowBreak }

%\transpose g e 
\new ChoirStaff 
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \revert Staff.TimeSignature.style \key g \major \time 6/8 \cadenzaOn \tempo "Très joyeux, souple et doux"
          b8 b [a b] c2. b4\fermata\resp b8 b [a b] b [a b] c2. b4.\fermata\resp
          b4 8 a4 g8 a4. 4 b8 g2.\fermata
          \bar"|."
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'' 
        {
          g8 a [g a] g ([a g] fis [e fis]) g4 
          8 8 [8 8] 8 [8 8] g ([a g] fis [e fis]) g4.
          g8 [(fis) g] fis [(e) d] e ([ fis g]) fis [(e) fis] d2.
      } }
   >>
   \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { \set associatedVoice = #"soprano"
     Joy -- eu -- se lu -- miè -- re_!_
     Splen -- deur é -- ter -- nel -- le du Pè -- re_!_
     Saint et bien -- heu -- reux, Jé -- sus Christ_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \revert Staff.TimeSignature.style \key g \major \cadenzaOn
          d8 d [c d] e4. (d) d4 d8 d [c d] d [c d] e4. (d) d
          d4 8 c4 b8 c4. 4 d8 b2.
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          g8 g [g g] c,4. (d) <g, g'>4\fermata\resp
          g'8 g [g g] g [g g] c,4. (d) <g, g'>4.\fermata\resp
          g'4 8 d4 8 4. 4 8 <g, g'>2.\fermata
      } }
   >>
>>