\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose bes g
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver } 
   <<  \new Voice = "soprano" {
     \relative c'' {
       \clef "treble" \key g \minor \time 2/4 \tempo "Doux" 4 = 120 
       \override Staff.BarLine.stencil = ##f
       \partial8 \voiceOne bes8 bes4 a8 [bes] g4. d'8 d4.-\markup\italic"cresc."
       c8 bes16 [(a) g8~]g4 \breathe
       bes8 [bes] a [bes] g4 bes8 [a] \allowBreak g4 f8 [f] g4 \breathe 
       \oneVoice r8\voiceOne \allowBreak bes^\mf bes4 a8 ([bes]) g4. d'8 d4. c8 bes16 [(a g8~]g4) \breathe
       bes8 [bes] a ([bes]) g4 bes8 [a] g4 (f) \noBreak g2\fermata \bar "|."
     }
     \revert Staff.BarLine.stencil \cadenzaOn \tonIIaf
       }
   >>
   \new Lyrics \lyricmode {
     \set associatedVoice = #"soprano"
     Ray8 -- on4 -- ne8 de joie,4. Vier8 -- ge4. Ma8 -- ri -- e,4.
     car8 sur toi se lè4 -- ve8 la gloi4 -- re8 de Dieu.4 
     \skip 8 Al8 -- lé4 -- lu -- ia,4. Al8 -- lé4. -- lu8 -- ia,2
     Al8 -- lé -- lu4 -- ia, Al8 -- lé -- lu2 -- ia_!
   }
   \new Lyrics = "hommes" \with {\override VerticalAxisGroup.staff-affinity = #DOWN }
   \new Staff \with {\remove Time_signature_engraver } 
   << \new Voice = "ténor" {
     \relative c' {
       \clef "bass" \key g \minor \time 2/4
       \override Staff.BarLine.stencil = ##f
       r8 \voiceOne bes4 (c) d (ees) d (c) d (c) d (c) d (ees) d (c) d (c)
       bes4 (c) d (ees) d (c) d (c) d (c) d (ees) d (c) d2
     }
     \revert Staff.BarLine.stencil \cadenzaOn \tonIIah
      }
      \new Voice = "basse" {
        \voiceTwo \relative c' {
          s8 g4 (a) bes (c) bes (a) g (a) \breathe g (a) bes (c) bes (a) g (a) \breathe
          g4 (a) bes (c) bes (a) g (a) \breathe g (a) bes (c) bes (a) g2 \fermata
        }
      }
   >>
   \context Lyrics = "hommes" \lyricsto "basse" {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia,
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia_!
   }
>>