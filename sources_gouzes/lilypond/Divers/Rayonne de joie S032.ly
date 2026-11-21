\version "2.24.0"

\new ChoirStaff  %\with { instrumentName = #"2" }
<< \new Staff \with {\remove Time_signature_engraver }
    \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \minor \cadenzaOn \tempo "Doux" 4 = 120
          bes8 bes4 a8 [bes] g4. d'8^"cresc." d4. c8 bes16 [(a) g8]~g4 \breathe \allowBreak  bes8 [bes] a [bes] g4 bes8 [a] g4 f8 [f] g4 \breathe \allowBreak
          r8 bes^\mf  bes4 a8 ([bes]) g4. d'8 d4. c8 bes16 ([a g8]~g4) \breathe \allowBreak bes8 [bes] a ([bes]) g4 bes8 [a] g4 (f) g2 \bar "|."
           } 
           <<
          \transpose c bes {\relative c' { c \breve b8[ c] a4 \bar "|" \noBreak b \breve g \breve a4 \bar "||" \noBreak c \breve  a4-+ \bar "|." } }
          \new Voice = "alto" {\voiceTwo \cadenzaOn
                               \transpose c bes {\relative c' { a \breve s4 f4 \bar "|" f \breve e \breve e4 \bar "||" a \breve  f4 } } }
           >>
      }
   
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano"
      Ray8 -- on4 -- ne8 de joie,4. Vier8 -- ge4. Ma8 -- ri -- e4. car8 sur toi se lè4 -- ve8 la gloi4 -- re8 de Dieu,4.
      Al8 -- lé4 -- lu -- ia,4. Al8 -- lé4. -- lu8 -- ia,2 Al8 -- lé -- lu4 -- ia, Al8 -- lé -- lu2 -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \minor \cadenzaOn 
          r8 bes4 (c) d (ees) d (c) d (c) d (c) d (ees) d (c) d (c) 
          bes4 (c) d (ees) d (c) d (c) d (c) d (ees) d (c) d2 
          \transpose c bes {\relative c { e \breve s4 d4 \bar "|" d \breve b \breve c4 \bar "||" e \breve d4 } } }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          s8 g4 (a) bes (c) bes (a) g (a) \breathe g (a) bes (c) bes (a) g (a) \breathe
          g (a) bes (c) bes (a) g (a) \breathe g (a) bes (c) bes (a) g2 
          \transpose c bes {\relative c { a \breve s4 d,4 \bar "|" d \breve e \breve <a, a'>4 \bar "||" a' \breve a4 } } }
      }
   >>
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"basse"
      \skip4 Al2 -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia_!
   }
>>