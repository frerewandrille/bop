%\include "TonsDef.ly"

\transpose bes g
\new ChoirStaff  %\with { instrumentName = #"1" }
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \key bes \major \cadenzaOn \tempo 4 = 88
          bes8 [bes] c [bes] bes4. \breathe \allowBreak 
          d8 d [c] bes [bes] g4. \breathe \allowBreak 
          bes8 bes ([g]) bes ([d] c [bes]) bes4 \fermata \bar "|."
          bes \breve c4 \bar "|" \noBreak bes \breve g \breve bes8[ c] bes 4 \bar "||" \noBreak bes \breve  g4-+ \bar "|."
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        {
          f8 [f] g [g] f4. bes8 bes [g] g [g] ees4. g8 g ([ees]) f4 (g) f
          f \breve g4 \bar "|" f \breve g \breve s4 f4 \bar "||" f \breve  ees 4
      } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Au8 ma -- tin, Sei -- gneur,4. je8 viens dans ta mai -- son,4. al8 -- lé4 -- lu2 -- ia_!4
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key bes \major \cadenzaOn
          d8 [d] ees [ees] d4. f8 f [ees] ees [d] c4. d8 d ([bes]) d4 (ees) d
          d \breve ees4 \bar "|" d \breve ees \breve s4 d4 \bar "||" d \breve bes4
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          bes8 [bes] bes [bes] bes4. \breathe bes8 bes [bes] bes [bes] c4. \breathe g8 g4 f (ees) bes' \fermata
          bes \breve bes4 bes \breve ees, \breve s4 bes'4 bes \breve ees,4
      } }
   >>
>>