\version "2.24.0"
%\include "TonsDef.ly"


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/2 \cadenzaOn \tempo  2 = 54
          g2 g1\fermata\breathe\allowBreak a2 a1.\fermata\breathe\allowBreak
          bes2 bes bes a1 a2 bes1 bes2 a1.\fermata\bar "|."
        }\tonIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d1 d2 cis1. d2 d d e1 e2 d1 d2 d1.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Mon Dieu, mon Dieu_! Pour -- quoi m’as_- tu a -- ban -- don -- né_?
   }

   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 3/2 \cadenzaOn
          bes2 bes1 bes2 bes1. g2 g g g1 g2 g1 e!2 fis1.
        }\tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 f1\fermata\breathe f2 e1.\fermata\breathe
          d2 d d cis1 cis2 d1 d2 d1.\fermata
        }
      }
   >>
>>