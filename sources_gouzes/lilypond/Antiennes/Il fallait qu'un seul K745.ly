\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Lent" 2 = 44
          a4^\< a^\> a1\fermata\!\resp a4 a a bes bes^\< (a)^\> a2.\fermata\!\resp
          a2 a4 d d2 (cis4 b) a1\fermata
          \bar"|."
        } \tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f e1 e4 e e g g2 f2. f2 e4 d d1 e
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Il fal -- lait qu’un seul hom -- me meu -- re pour tout le peu -- ple.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a a1 a4 a a a a2 a2. a2 a4 a b1 cis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d cis1\fermata\resp cis4 cis cis cis d2 d2.\fermata\resp
          d2 e4 f g2 (gis) a1\fermata
        } \tonIch
      }
   >>
>>