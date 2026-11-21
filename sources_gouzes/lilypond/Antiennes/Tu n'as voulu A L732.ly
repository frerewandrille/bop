\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn \tempo "Lent" 4 = 72
          d2 4 4 2. \resp 4 ees d ees2. (d4) c2 \resp a4 c bes2 (a) g\fermata\bar"|"
          g4 8 [8] g2\resp 4 2 fis!4 g2\fermata
          \bar "|."
        } \transpose c bes, \tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 fis4 4 g2. 4 4 4 1 fis!2 fis!4 4 g2. (fis!4) d2
          4 8 [8] ees2 d4 2 4 2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu n’as vou -- lu ni ho -- lo -- caus -- te, ni vic -- ti -- me, 
     a -- lors j’ai dit_: "“Voi" -- ci, je "viens !”"
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 3/4 \cadenzaOn
          bes2 a4 4 bes2. 4 c b c2. (bes4) a2 c4 a d1 bes2
          4 8 [8] c2 bes4 a2 4 b?2
        } \transpose c bes, \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 d4 d g2. \resp 4 c, d c2. (d4) ees2 \resp d4 ees d1 g2\fermata
          g4 8 [8] c,2\fermata\resp d4 2 4 g2\fermata
        }
      }
   >>
>>