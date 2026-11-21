\version "2.24.0"
%\include "TonsDef.ly"

\transpose f d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key bes \major \time 1/4 \cadenzaOn \tempo 4 = 86
          f8 [g] bes4 bes8 [bes] bes [bes] c [d]
          bes4. (g8 f [g] ) bes2 \breathe \allowBreak
          d8 [d16 d] d8 [d] c16 [(bes) c8] d2\fermata
          \bar "|."
        } \transpose c bes, \tonVIIIdf
        %\transpose a bes \tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f8 [g] bes4 bes8 [bes] bes [bes] c [d]
          bes4. (g8 f [g] ) bes2 
          bes8 [bes16 bes] bes8 [bes] g [g16 (a)] bes2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Au ma -- tin, tu as vi -- si -- té la ter -- re,
     et tu l’as fait dan -- ser de joie_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c 
        { \clef "bass" \key bes \major\cadenzaOn
          f8 [g] bes4 bes8 [bes] bes [bes] c [d]
          bes4. (g8 f [g] ) bes2
          f'8 [f16 f] f8 [f] ees16 [(d) ees8] f2
        } \transpose c bes, \tonVIIIdh
        %\transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 [g] bes4 bes8 [bes] bes [bes] c [d]
          bes4. (g8 f [g] ) bes2 \breathe
          bes8 [bes16 bes] bes8 [bes] c [c] bes2\fermata
        }
      }
   >>
>>