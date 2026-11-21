\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \minor \time 4/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Détaché" 4 = 112
          g4-- g-- a-- a-- g-- g8-- [g--] a4-- a-- a2-> a4\resp
          a8 [a] bes4-> bes8 [bes] a2 a4-- a-- a2\fermata
          \bar"|."
        } \transpose b a \tonIIIdf
        %\tonVImf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d f f e e8 [e] f4 f e2 e4 e8 [e] g4 g8 [g] e2 f4 f e2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ils s’a -- char -- nent con -- tre la vie du Jus -- te 
      et con -- dam -- nent le sang in -- no -- cent.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b c c c c8 [c] c4 c cis2 cis4 
          cis8 [cis] d4 d8 [d] cis!2 d4 d cis!2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4-- g-- f-- f-- c-- c8-- [c--] f4-- f-- a2-> a4\resp
          a8 [a] g4-> g8 [g] a2 d,4-- d-- a'2\fermata
        } \transpose b a \tonIIIdh
        %\tonVImh
      }
   >>
>>