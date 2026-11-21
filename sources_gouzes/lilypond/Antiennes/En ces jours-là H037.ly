\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key ees \major \time 3/4 %\omit Score.BarLine %\tempo "" 2 = 52
          \partial 4 g4 g2 g4 ees2 g4 bes4. bes8 c bes g2 g4 aes2 f4 g2 f8 g aes2 (bes4) \noBreak g2.\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \tonVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial 4 ees4 ees2 ees4 bes2 ees4 g4. g8 aes g ees2 ees4 f2 d4 ees2 d8 ees f2 (d4) ees2.
        }          
      }
   >>
   \new Lyrics \lyricsto "soprano"
   { %\set associatedVoice = #"soprano"
     En ces jours_- là, la paix se lè -- ve -- ra à l’O -- ri -- ent, al -- lé -- lu -- ia_!
   }
   \new Lyrics = "Hommes" \with {\override VerticalAxisGroup.staff-affinity = #DOWN }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "tenor"
      { \voiceOne \relative c'
        { \clef "bass" \key ees \major
          \partial 4 bes4 bes2 bes4 g2 bes4 ees2 ees4 bes2 bes4 bes2 bes4 bes2 bes4 bes2 bes4 bes2.
        }\cadenzaOn \tonVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial 4 \repeat unfold 4 { ees4 ees2 } ees4 bes2 bes4 ees2 ees4 bes2 bes4 ees2.\fermata
        }
      }
   >>
   \context Lyrics = "Hommes" { 
     \lyricsto "tenor" 
     {
       Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     }
   }
>>