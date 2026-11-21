\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose g e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   \with { \consists "Merge_rests_engraver" }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo ""
          g4 g2 d'4 d2 \fermata\allowBreak\breathe 
          g,4 ees'2 f8 ([ees]) ees4^> (d2\fermata)\allowBreak\breathe
          r2 d4 d4^> c c1\fermata\allowBreak\breathe
          c4 bes bes1 \allowBreak bes4 bes a1 \allowBreak ees2 g d1\fermata\bar "|."
        }\tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g2 g4 g2 g4 g2 g4 g2. r2 g4 ees ees d1 d4 d ees1 ees4 ees c1 c2 c d1
        } 
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Jé -- ru -- sa -- lem_! Jé -- ru -- sa -- lem_! 
     Com -- bien de fois, j’ai vou -- lu ras -- sem -- bler tes en -- fants_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 3/4 \cadenzaOn
          g4 g2 bes4 bes2 g4 c2 d8 ([c]) c4 (bes2\fermata) 
          r2 bes4 g g a1 a4 a g1 g4 g g1 g2 g a1
        }\tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g2 g4 g2\fermata\allowBreak\breathe g4 g2 g4 g2.\fermata\allowBreak\breathe 
          r2 g4 c,_> c f1\fermata\allowBreak\breathe 
          f4 f c1 c4 c ees1 c2 ees d1\fermata 
        }
      }
   >>
>>