\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          bes4 a8 [bes] c2 \resp
          c\breve*1/16 bes8 [c] d [d] ees [ees] d4 c\resp
          c\breve*1/16 bes2^\markup\italic"rall." g4 a bes2\fermata \bar "|."
        } \transpose a bes \tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          f4 f8 [f] f2 
          f\breve*1/16 f8 [f] bes [bes] bes [bes] bes4 a
          a\breve*1/16 f2 ees4 ees f2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
     Ô Christ sau -- veur, 
     "c’est dans le livre " de ta croix que Do -- mi -- ni -- que 
     "apprit le che" -- min de la vie.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 2/2 \cadenzaOn
          d4 bes8 [d] ees2 
          ees\breve*1/16 d8 [ees] f [f] g [g] f4 f 
          ees\breve*1/16 d2 c4 c d2
        } \transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          bes4 f8 [bes] a2 \resp 
          f\breve*1/16 bes8 [bes] bes [bes] ees, [ees] f4 f\resp
          f\breve*1/16 f2 f4 f4 <bes, bes'>2\fermata
        }
      }
   >>
>>